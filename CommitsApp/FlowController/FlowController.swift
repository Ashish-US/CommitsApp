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

class FlowController: FlowControllable {
    var navController: UINavigationController?
    init(navController: UINavigationController?) {
        self.navController = navController
    }
    
    func startCommitFlow() {
        let viewModel = CommitsViewModel()
        let commitVC = CommitsViewController(viewModel: viewModel,
                                             flowController: self)
        
        navController?.pushViewController(commitVC, animated: true)
    }
}
