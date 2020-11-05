//
//  Person.swift
//  MVP-LevelOne
//
//  Created by Dima Khymych on 28.09.2020.
//

import Foundation

struct Comment: Codable {
    let postID, id: Int?
    let name, email, body: String?

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}
