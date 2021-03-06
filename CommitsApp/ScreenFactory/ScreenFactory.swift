//
//  ScreenFactory.swift
//  CommitsApp
//
//  Created by Ashish Singh on 9/26/21.
//

import UIKit

// All navigation state for the app, whenever new screen is added this to be updated
enum CommitAppScreen {
    case commitScreen
    case otherScreen
    // add more screens as app grows
}

//******************************************************************************
// ScreenFactory will creat all all screens with provided dependencies
//
//******************************************************************************

class ScreenFactory {
    static func create(for screen: CommitAppScreen,
                       viewModel: CommitsViewable,
                       flowController: FlowControllable,
                       activityPresenter: ActivityPresentable) -> UIViewController? {
        switch screen {
        case .commitScreen:
            return CommitsViewController(viewModel: viewModel,
                                         flowController: flowController,
                                         activityPresenter: activityPresenter)
            
        default:
            return nil
        }
        
        
    }
}


