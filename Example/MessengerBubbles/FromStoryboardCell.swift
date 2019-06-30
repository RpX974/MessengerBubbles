//
//  FromStoryboardCell.swift
//  MessengerBubbles_Example
//
//  Created by Laurent Grondin on 28/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import MessengerBubbles

protocol ConfigureCell {
    func configure(with user: User?, isOnline: Bool)
    func configure(with group: Group?, isOnline: Bool)
}

class FromStoryboardCell: UITableViewCell, ConfigureCell {
    
    @IBOutlet weak var bubble: MessengerBubbles!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(with user: User?, isOnline: Bool) {
        guard let data = user else { return }
        bubble.setImages(with: [data.photo])
        bubble.isOnline = isOnline
        nameLabel.text = data.username
        descriptionLabel.text = data.description
    }
    
    func configure(with group: Group?, isOnline: Bool) {
        guard let data = group else { return }
        bubble.setImages(with: data.users.map { $0.photo })
        bubble.isOnline = isOnline
        nameLabel.text = data.name
        descriptionLabel.text = data.description
    }
    
}
