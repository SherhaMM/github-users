//
//  UserModel.swift
//  Ingenious.Build.Task
//
//  Created by Makcim Mikhailov on 29/02/2024.
//

import Foundation

struct UserModel: Codable {
    let id: Int
    let login: String
}

extension UserModel: Identifiable { }

extension UserModel: Hashable { }

