//
//  UserDetailsObject.swift
//  Ingenious.Build.Task
//
//  Created by Makcim Mikhailov on 02/03/2024.
//

import Foundation
import SwiftData

@Model
final class UserDetailsObject {
    let id: Int
    let login: String
    let avatarUrl: String
    let name: String?
    let company: String?
    let bio: String?
    
    init(id: Int, login: String, avatarUrl: String, name: String?, company: String?, bio: String?) {
        self.id = id
        self.login = login
        self.avatarUrl = avatarUrl
        self.name = name
        self.company = company
        self.bio = bio
    }
}

extension UserDetailsObject {
    var toModel: UserDetailsModel {
        UserDetailsModel(id: id, login: login, avatarUrl: avatarUrl, name: name, company: company, bio: bio)
    }
    
    convenience init(from model: UserDetailsModel) {
        self.init(id: model.id, login: model.login, avatarUrl: model.avatarUrl, name: model.name, company: model.company, bio: model.bio)
    }
}
