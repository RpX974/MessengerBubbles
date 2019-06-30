//
//  Models.swift
//  MessengerBubbles_Example
//
//  Created by Laurent Grondin on 28/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

struct User {
    let username: String
    let photo: String
    let description: String
}

struct Group {
    let users: [User]
    let name: String
    let description: String
}

extension User {
    static var dataSource: [User] {
        return [User(username: "John Doe",
                     photo: "https://media.cdnandroid.com/b1/b5/9e/8f/imagen-3d-wild-animals-live-wallpaper-0big.jpg",
                     description: "This is from a User"),
                User(username: "Janette Doe",
                     photo: "https://ae01.alicdn.com/kf/HTB10hgEkol7MKJjSZFDq6yOEpXa6/1103-Fresco-Macro-Nyan-Cat-Occhiali-Wall-Sticker-Art-Poster-Per-La-Decorazione-Domestica-Pittura-Della.jpg_640x640.jpg",
                     description: "This is from one User")
        ]
    }
}

extension Group {
    static var dataSource: Group {
        return Group(users: User.dataSource,
                     name: "Party",
                     description: "This is from a Group")
    }
}
