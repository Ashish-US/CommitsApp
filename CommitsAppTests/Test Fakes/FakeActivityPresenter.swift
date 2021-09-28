//
//  FakeActivityPresenter.swift
//  CommitsAppTests
//
//  Created by Ashish Singh on 9/27/21.
//

import UIKit
@testable import CommitsApp

class FakeActivityPresenter: ActivityPresentable {
    
    var didCallShowActivityIndicator = false
    func showActivityIndicator(on view: UIView) {
        didCallShowActivityIndicator = true
    }
    
    var didCallHideActivityIndicator = false
    func hideActivityIndicator() {
        didCallHideActivityIndicator = true
    }
}
