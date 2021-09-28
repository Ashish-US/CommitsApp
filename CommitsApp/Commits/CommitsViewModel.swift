//
//  CommitsViewModel.swift
//  CommitsApp
//
//  Created by Ashish Singh on 9/25/21.
//
import Foundation

protocol CommitsViewable {
    func getCommits(completion: @escaping ([Commits]?, Error?) -> Void)
}

class CommitsViewModel: CommitsViewable {
    var networkRequest: NetworkRequest?
    func getCommits(completion: @escaping ([Commits]?, Error?) -> Void) {
        if let request = NetworkRequest.RequestType.getCommit.networkRequest() {
            request.fetchCommits(completion: { commit, error in
                completion(commit, error)
            })
        }
    }
}
