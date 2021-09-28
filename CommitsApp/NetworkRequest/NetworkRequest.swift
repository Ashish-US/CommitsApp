//
//  NetworkRequest.swift
//  CommitsApp
//
//  Created by Ashish Singh on 9/26/21.
//

import Foundation

enum RequestError: Error {
  case invalidResponse
  case networkCreationError
  case otherError
  case sessionExpired
}

struct NetworkRequest {
    typealias NetworkResult<T: Decodable> = (response: HTTPURLResponse, object: T)
    
    // MARK: Private Constants
    static let callbackURLScheme = "CommitsApp"
    static let clientID = "Iv1.4c615f2cefd678da"
    static let clientSecret = "ca69a43167c58cfbf5f76523ef61b1c241887a2c"
    
    // MARK: Properties
    var method: HTTPMethod
    var url: URL
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum RequestType: Equatable {
        case codeExchange(code: String)
        case getCommit
        case signIn
        
        func networkRequest() -> NetworkRequest? {
            guard let url = url() else {
                return nil
            }
            return NetworkRequest(method: httpMethod(), url: url)
        }
        
        private func httpMethod() -> NetworkRequest.HTTPMethod {
            switch self {
            case .codeExchange:
                return .post
            case .getCommit:
                return .get
            case .signIn:
                return .get
            }
        }
        
        private func url() -> URL? {
            switch self {
            case .codeExchange(let code):
                let queryItems = [
                    URLQueryItem(name: "client_id", value: NetworkRequest.clientID),
                    URLQueryItem(name: "client_secret", value: NetworkRequest.clientSecret),
                    URLQueryItem(name: "code", value: code)
                ]
                return urlComponents(host: "github.com", path: "/login/oauth/access_token", queryItems: queryItems).url
                
            case .getCommit:
                return urlComponents(path: "/repos/\(username ?? "")/CommitsApp/commits", queryItems: nil).url
                
            case .signIn:
                let queryItems = [
                    URLQueryItem(name: "client_id", value: NetworkRequest.clientID)
                ]
                
                return urlComponents(host: "github.com", path: "/login/oauth/authorize", queryItems: queryItems).url
            }
        }
        
        private func urlComponents(host: String = "api.github.com", path: String, queryItems: [URLQueryItem]?) -> URLComponents {
            switch self {
            default:
                var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = host
                urlComponents.path = path
                urlComponents.queryItems = queryItems
                return urlComponents
            }
        }
    }
    
    
    // MARK: Static Methods
    static func signOut() {
        Self.accessToken = ""
        Self.refreshToken = ""
        Self.username = ""
    }
    
    // MARK: Methods
    func login<T: Decodable>(responseType: T.Type, completionHandler: @escaping ((Result<NetworkResult<T>, Error>) -> Void)) {
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let accessToken = NetworkRequest.accessToken {
            request.setValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completionHandler(.failure(RequestError.invalidResponse))
                }
                return
            }
            guard error == nil, let data = data else {
                DispatchQueue.main.async {
                    let error = error ?? RequestError.otherError
                    completionHandler(.failure(error))
                }
                return
            }
            
            if T.self == String.self, let responseString = String(data: data, encoding: .utf8) {
                let components = responseString.components(separatedBy: "&")
                var dictionary: [String: String] = [:]
                for component in components {
                    let itemComponents = component.components(separatedBy: "=")
                    if let key = itemComponents.first, let value = itemComponents.last {
                        dictionary[key] = value
                    }
                }
                DispatchQueue.main.async {
                    NetworkRequest.accessToken = dictionary["access_token"]
                    NetworkRequest.refreshToken = dictionary["refresh_token"]
                    completionHandler(.success((response, "Success" as! T)))
                }
                return
            }
        }
        session.resume()
    }
    
    func fetchCommits(completion: @escaping ([Commits]?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if let accessToken = NetworkRequest.accessToken {
            request.setValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = response as? HTTPURLResponse else {
                completion(nil, RequestError.invalidResponse)
                return
            }
            guard error == nil, let data = data else {
                completion(nil, RequestError.otherError)
                return
            }
            
            do {
                let res = try JSONDecoder().decode([Commits].self, from: data)
                completion(res, nil)
            } catch let err {
                completion(nil, err)
            }
        }
        session.resume()
    }
}

extension NetworkRequest {
    // MARK: Private Constants
    private static let accessTokenKey = "accessToken"
    private static let refreshTokenKey = "refreshToken"
    private static let usernameKey = "username"
    
    // MARK: Properties
    static var accessToken: String? {
        get {
            UserDefaults.standard.string(forKey: accessTokenKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: accessTokenKey)
        }
    }
    
    static var refreshToken: String? {
        get {
            UserDefaults.standard.string(forKey: refreshTokenKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: refreshTokenKey)
        }
    }
    
    static var username: String? {
        get {
            UserDefaults.standard.string(forKey: usernameKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: usernameKey)
        }
    }
}
