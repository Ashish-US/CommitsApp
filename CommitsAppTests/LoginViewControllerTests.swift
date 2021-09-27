//
//  LoginViewControllerTests.swift
//  CommitsAppTests
//
//  Created by Ashish Singh on 9/26/21.
//

import XCTest
@testable import CommitsApp

class LoginViewControllerTests: XCTestCase {
    
    var subject: LoginViewController!
    var viewModel: FakeLoginViewModel!
    var flowController: FakeFlowController!
    
    func testInitialization() {
        viewModel = FakeLoginViewModel()
        flowController = FakeFlowController()

        subject = LoginViewController(viewModel: viewModel,
                                      flowController: flowController)
        XCTAssertNotNil(subject.view)
    }

    func testLoginSuccess() {
        viewModel = FakeLoginViewModel()
        flowController = FakeFlowController()

        subject = LoginViewController(viewModel: viewModel,
                                      flowController: flowController)
        viewModel.loginSuccess = true
        subject.login()
        XCTAssertTrue(viewModel.didCallLogin)
        XCTAssertTrue(flowController.didCallStartCommitFlow)
    }

    func testLoginFail() {
        viewModel = FakeLoginViewModel()
        flowController = FakeFlowController()

        subject = LoginViewController(viewModel: viewModel,
                                      flowController: flowController)
        viewModel.loginSuccess = false
        subject.login()
        XCTAssertTrue(viewModel.didCallLogin)
        XCTAssertFalse(flowController.didCallStartCommitFlow)
    }

}
