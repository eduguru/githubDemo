//
//  User.swift
//  githubDemo
//
//  Created by Edwin Weru on 26/05/2022.
//

import Foundation

struct UserModel: Codable {
    
    var id: Int
    var login: String
    var node_id: String
    var avatar_url: String
    var score: Double
    
    init(model: Item) {
        self.id = model.id
        self.login = model.login
        self.node_id = model.node_id
        self.avatar_url = model.avatar_url
        self.score = model.score
    }
}
