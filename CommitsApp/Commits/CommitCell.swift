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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var author: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var hashLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [message, author, hashLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 5
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
    }
}


