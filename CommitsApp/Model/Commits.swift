//
//  Commits.swift
//  CommitsApp
//
//  Created by Ashish Singh on 9/25/21.
//

import Foundation

struct Commits: Codable {
    var comments_url: String?
    var commit: Commit?
    var html_url: String?
    var parent: Parent?
    var sha: String?
    var url: String?
}

extension Commits {
    static func dummy() -> Commits {
        return Commits(comments_url: "test-comment",
                       commit: nil, html_url: "test-html", parent: nil, sha: "test-sha", url: "test-url")
    }
}


struct Commit: Codable {
    var author: Author?
    var comment_count: Int?
    var committer: Committer?
    var message: String?
    var tree: Tree?
    var url: String?
    var verification: Verification?
}

struct Verification: Codable {
    var payload: String?
    var reason: String?
    var signature: String?
    var verified: Bool?
}

struct Author: Codable {
    var date: String?
    var email: String?
    var name: String?
}

struct Committer: Codable {
    var date: String?
    var email: String?
    var name: String?
}

struct Parent: Codable {
    var html_url: String?
    var sha: String?
    var url: String?
}

struct Tree: Codable {
    var sha: String?
    var url: String?
}
