//
//  CommitCell.swift
//  CommitsApp
//
//  Created by Ashish Singh on 9/26/21.
//

import UIKit

class CommitCell: UITableViewCell {

    var message: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var author: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var hashLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [message, author, hashLabel, seperatorView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .leading
        stackView.spacing = 2
        return stackView
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    override func prepareForReuse() {
      super.prepareForReuse()
      
      configure(loading: false)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

  func configure(loading: Bool) {
  }
    
    func setUpCell() {
        let marginGuide = contentView.layoutMarginsGuide

        // add album name
        contentView.addSubview(vStackView)
        setupStackConstraints()
    }
    
    func setupStackConstraints() {
        [vStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        vStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        vStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: 5),
        vStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -5)].forEach {
            $0.isActive = true
        }
        
        seperatorView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
}


