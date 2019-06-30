//
//  FromCodeCell.swift
//  MessengerBubbles_Example
//
//  Created by Laurent Grondin on 28/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import MessengerBubbles

class FromCodeCell: UITableViewCell, ConfigureCell {
    
    lazy var bubbleView: MessengerBubbles = {
        let iv = MessengerBubbles(size: 60)
        return iv
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.nameLabel, self.descriptionLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.selectionStyle = .none
        bubbleView
            .addTo(contentView)
            .vAnchor(top: nil, leading: self.contentView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0))
            .centerYToSuperview()
        stackView
            .addTo(contentView)
            .vAnchor(top: bubbleView.topAnchor,
                     leading: bubbleView.trailingAnchor,
                     bottom: bubbleView.bottomAnchor,
                     trailing: contentView.trailingAnchor,
                     padding: .init(top: 5, left: 10, bottom: 5, right: 10))
    }
    
    func configure(with user: User?, isOnline: Bool) {
        guard let data = user else { return }
        bubbleView.setImages(with: [data.photo])
        bubbleView.isOnline = isOnline
        nameLabel.text = data.username
        descriptionLabel.text = data.description
    }
    
    func configure(with group: Group?, isOnline: Bool) {
        guard let data = group else { return }
        bubbleView.setImages(with: data.users.map { $0.photo })
        bubbleView.isOnline = isOnline
        nameLabel.text = data.name
        descriptionLabel.text = data.description
    }
}
