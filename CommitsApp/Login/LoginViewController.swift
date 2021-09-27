//
//  ViewController.swift
//  CommitsApp
//
//  Created by Ashish Singh on 9/25/21.
//

import UIKit

class LoginViewController: UIViewController {
    var viewModel: LoginViewable = LoginViewModel()
    var flowController: FlowControllable = FlowController(navController: nil)
    
    let loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Login To GitHub", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.isHidden = false
        button.titleLabel?.font = .preferredFont(forTextStyle: .title1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(viewModel: LoginViewable,
         flowController: FlowControllable) {
        self.viewModel = viewModel
        self.flowController = flowController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flowController = FlowController(navController: navigationController)
        self.title = "LOGIN"
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        setupConstraint()
        
        // if access token exist directly show the commits screen
        flowController.startCommitFlow()
    }
    
    @objc func login() {
        viewModel.login { [weak self] loginSuccess in
            if loginSuccess {
                self?.flowController.startCommitFlow()
            }
        }
    }
    
    private func setupConstraint() {
        [loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
        loginButton.heightAnchor.constraint(equalToConstant: 50)].forEach {
            $0.isActive = true
        }
    }
}

