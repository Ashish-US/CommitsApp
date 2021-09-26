//
//  FakeFlowController.swift
//  CommitsAppTests
//
//  Created by Ashish Singh on 9/26/21.
//

import Foundation
@testable import CommitsApp

class FakeFlowController: FlowControllable {
    
    var didCallStartCommitFlow = false
    func startCommitFlow() {
        didCallStartCommitFlow = true
    }
}
