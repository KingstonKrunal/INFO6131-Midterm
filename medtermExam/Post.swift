//
//  Post.swift
//  medtermExam
//
//  Created by Abdalla Elnajjar on 2022-06-05.
//

import Foundation
import Foundation

// MARK: - PostElement
struct Post: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}


