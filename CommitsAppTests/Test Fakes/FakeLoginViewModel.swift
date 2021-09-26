//
//  FakeLoginViewModel.swift
//  CommitsAppTests
//
//  Created by Ashish Singh on 9/26/21.
//

import Foundation
@testable import CommitsApp

class FakeLoginViewModel: LoginViewable {
    var didCallLogin = false
    var loginSuccess = false
    func login(completion: @escaping (Bool) -> Void) {
        didCallLogin = true
        completion(loginSuccess)
    }
}
