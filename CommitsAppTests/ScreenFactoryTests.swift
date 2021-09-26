//
//  ScreenFactoryTests.swift
//  CommitsAppTests
//
//  Created by Ashish Singh on 9/26/21.
//

import XCTest
@testable import CommitsApp

class ScreenFactoryTests: XCTestCase {
    var subject: ScreenFactory!
    var navController: UINavigationController!
    
    func testCreateSuccess() {
        subject = ScreenFactory()
        let viewModel = FakeCommitsViewModel()
        let flowController = FakeFlowController()
        let commitVC = ScreenFactory.create(for: .commitScreen,
                                            viewModel: viewModel,
                                            flowController: flowController)
        if let vc = commitVC as? CommitsViewController {
            XCTAssertNotNil(vc, "Unable to create Commits View controller")
        }
    }

    func testCreateFail() {
        subject = ScreenFactory()
        let viewModel = FakeCommitsViewModel()
        let flowController = FakeFlowController()
        let vc = ScreenFactory.create(for: .otherScreen,
                                      viewModel: viewModel,
                                      flowController: flowController)
        XCTAssertNil(vc)
    }

}
