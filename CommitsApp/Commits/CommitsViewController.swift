//
//  CommitsViewController.swift
//  CommitsApp
//
//  Created by Ashish Singh on 9/25/21.
//

import UIKit

class CommitsViewController: UIViewController, UITableViewDelegate {
    
    var viewModel: CommitsViewable
    var flowController: FlowControllable
    
    lazy var dataArray = [Commits]()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CommitCell.self, forCellReuseIdentifier: "CommitCell")
        return tableView
    }()

    init(viewModel: CommitsViewable,
         flowController: FlowControllable) {
        self.viewModel = viewModel
        self.flowController = flowController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = UIView(frame: UIScreen.main.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        setupConstraints()
        view.backgroundColor = .white
        self.title = "COMMITS"
        viewModel.getCommits { [weak self] commits, error in
            DispatchQueue.main.async {
                if let commits = commits {
                    self?.dataArray = commits
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    func setupConstraints() {
        [tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         tableView.heightAnchor.constraint(equalTo: view.heightAnchor),
         tableView.widthAnchor.constraint(equalTo: view.widthAnchor)].forEach {
            $0.isActive = true
        }
    }
}

extension CommitsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CommitCell", for: indexPath) as? CommitCell {
            cell.author.text = dataArray[indexPath.row].commit?.author?.name
            cell.message.text = dataArray[indexPath.row].commit?.message
            cell.hashLabel.text = dataArray[indexPath.row].commit?.tree?.sha
            return cell
        }
        return UITableViewCell()
    }
}
