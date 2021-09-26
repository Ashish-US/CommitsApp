//
//  CommitsViewModel.swift
//  CommitsApp
//
//  Created by Ashish Singh on 9/25/21.
//

protocol CommitsViewable {
    func getCommits(completion: @escaping ([Commits]?, Error?) -> Void)
}
import Foundation


class CommitsViewModel: CommitsViewable {
    
    func getCommits(completion: @escaping ([Commits]?, Error?) -> Void) {
        NetworkRequest
          .RequestType
          .getCommit
          .networkRequest()?
            .fetchCommits(completion: { commit, error in
                completion(commit, error)
            })
          }
    }
