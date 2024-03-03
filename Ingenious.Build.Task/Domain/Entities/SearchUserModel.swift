//
//  SearchUserModel.swift
//  Ingenious.Build.Task
//
//  Created by Makcim Mikhailov on 02/03/2024.
//

import Foundation

struct SearchUserModel: Codable {
    let totalCount: Int
    let users: [UserModel]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case users = "items"
    }
}
