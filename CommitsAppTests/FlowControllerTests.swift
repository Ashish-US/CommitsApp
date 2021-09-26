//
//  FlowControllerTests.swift
//  CommitsAppTests
//
//  Created by Ashish Singh on 9/26/21.
//

import XCTest
@testable import CommitsApp

class FlowControllerTests: XCTestCase {

    var subject: FlowController!
    var navController: UINavigationController!
    override func setUp() {
        super.setUp()
        navController = UINavigationController()
        subject = FlowController(navController: navController)
    }
    
    override func tearDown() {
        navController = nil
        subject = nil
        super.tearDown()
    }

    func testStartCommitFlow() {
        subject.startCommitFlow()
        let commitVC = navController.topViewController as? CommitsViewController
        XCTAssertNotNil(commitVC, "Unable to create Commits flow")
    }

}
