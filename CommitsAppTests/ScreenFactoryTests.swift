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
        let activityPresenter = ActivityPresenter()
        let commitVC = ScreenFactory.create(for: .commitScreen,
                                            viewModel: viewModel,
                                            flowController: flowController,
                                            activityPresenter: activityPresenter)
        
        if let vc = commitVC as? CommitsViewController {
            XCTAssertNotNil(vc, "Unable to create Commits View controller")
        }
    }

    func testCreateFail() {
        subject = ScreenFactory()
        let viewModel = FakeCommitsViewModel()
        let flowController = FakeFlowController()
        let activityPresenter = ActivityPresenter()

        let vc = ScreenFactory.create(for: .otherScreen,
                                      viewModel: viewModel,
                                      flowController: flowController,
                                      activityPresenter: activityPresenter)
        XCTAssertNil(vc)
    }

}
