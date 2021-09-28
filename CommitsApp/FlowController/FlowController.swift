//
//  FlowController.swift
//  CommitsApp
//
//  Created by Ashish Singh on 9/26/21.
//

import UIKit

protocol FlowControllable {
    func startCommitFlow()
    // more flow for future
}

//******************************************************************************
// FlowController will control the whole flow of app
// Individual screen will not know about business flow
//
// This class will also do dependency injection for all screens.
// Will inject flow controller, viewmodel instance etc, required for viewcontroller
//******************************************************************************

class FlowController: FlowControllable {
    var navController: UINavigationController?
    init(navController: UINavigationController?) {
        self.navController = navController
    }
    
    func startCommitFlow() {
        let viewModel = CommitsViewModel()
        let activityPresenter = ActivityPresenter()
        let commitVC = ScreenFactory.create(for: .commitScreen,
                             viewModel: viewModel,
                             flowController: self,
                             activityPresenter: activityPresenter)
        
        if let commitVC = commitVC {
            navController?.pushViewController(commitVC, animated: true)
        }
    }
}
