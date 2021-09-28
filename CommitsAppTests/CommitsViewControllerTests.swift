//
//  CommitsViewControllerTests.swift
//  CommitsAppTests
//
//  Created by Ashish Singh on 9/27/21.
//

import XCTest
@testable import CommitsApp

class CommitsViewControllerTests: XCTestCase {
    var subject: CommitsViewController!
    var viewModel: FakeCommitsViewModel!
    var flowController: FakeFlowController!
    var activityPresenter: FakeActivityPresenter!
    
    override func setUp() {
        viewModel = FakeCommitsViewModel()
        flowController = FakeFlowController()
        activityPresenter = FakeActivityPresenter()
        viewModel.commits = nil
        subject = CommitsViewController(viewModel: viewModel,
                                        flowController: flowController,
                                        activityPresenter: activityPresenter)
    }
    override func tearDown() {
        viewModel = nil
        flowController = nil
        activityPresenter = nil
        subject = nil
    }
    
    func testInitialization() {
        XCTAssertNotNil(subject.view)
    }

    func testGetCommitsSuccess() {
        viewModel.commits = [Commits.dummy()]
        subject.getData()
        XCTAssertTrue(viewModel.didCallGetCommits)
        XCTAssertTrue(activityPresenter.didCallShowActivityIndicator)
    }

    func testGetCommitsFail() {
        viewModel.commits = nil
        subject.getData()
        XCTAssertTrue(viewModel.didCallGetCommits)
        XCTAssertTrue(activityPresenter.didCallShowActivityIndicator)
    }
}
