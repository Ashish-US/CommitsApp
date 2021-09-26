//
//  LoginViewModel.swift
//  CommitsApp
//
//  Created by Ashish Singh on 9/25/21.
//

import Foundation
import AuthenticationServices
// MARK: Private Constants

protocol LoginViewable {
    func login(completion: @escaping (Bool) -> Void)
}

class LoginViewModel: NSObject, LoginViewable {
    // MARK: Private Constants
    private static let accessTokenKey = "accessToken"
    private static let refreshTokenKey = "refreshToken"
    private static let usernameKey = "username"

    static let callbackURLScheme = "CommitsApp"
    static let clientID = "Iv1.4c615f2cefd678da"
    static let clientSecret = "ca69a43167c58cfbf5f76523ef61b1c241887a2c"

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

    func login(completion: @escaping (Bool) -> Void) {
        guard let signInURL = NetworkRequest.RequestType.signIn.networkRequest()?.url else {
          print("Could not create the sign in URL .")
          return
        }

        let callbackURLScheme = NetworkRequest.callbackURLScheme
        let authenticationSession = ASWebAuthenticationSession(url: signInURL,
                                                               callbackURLScheme: callbackURLScheme) { [weak self] callbackURL, error in
          guard error == nil, let callbackURL = callbackURL,
            let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems,
            let code = queryItems.first(where: { $0.name == "code" })?.value,
            let networkRequest =
              NetworkRequest.RequestType.codeExchange(code: code).networkRequest()
          else {
            print("An error occurred when attempting to sign in.")
            completion(false)
            return
          }

          networkRequest.start(responseType: String.self) { result in
            switch result {
            case .success:
                print("Login Success")
              // navigate to commits screen
                completion(true)
            case .failure(let error):
              print("Failed to exchange access code for tokens: \(error)")
                completion(false)
            }
          }
        }

        authenticationSession.presentationContextProvider = self
        authenticationSession.prefersEphemeralWebBrowserSession = true

        if !authenticationSession.start() {
          print("Failed to start ASWebAuthenticationSession")
        }
    }
  }

extension LoginViewModel: ASWebAuthenticationPresentationContextProviding {
  func presentationAnchor(for session: ASWebAuthenticationSession)
  -> ASPresentationAnchor {
    let window = UIApplication.shared.windows.first { $0.isKeyWindow }
    return window ?? ASPresentationAnchor()
  }
}
