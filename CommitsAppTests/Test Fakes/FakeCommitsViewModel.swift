//
//  FakeCommitsViewModel.swift
//  CommitsAppTests
//
//  Created by Ashish Singh on 9/26/21.
//

import Foundation
@testable import CommitsApp

class FakeCommitsViewModel: CommitsViewable {
    var didCallgetCommits = false
    var commits: [Commits]?
    func getCommits(completion: @escaping ([Commits]?, Error?) -> Void) {
        didCallgetCommits = true
        if let commits = commits {
            completion(commits, nil)
        } else {
            let error = NSError(domain: "test-domain", code: 1, userInfo: nil)
            completion(nil, error)
        }
    }
}
