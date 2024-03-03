//
//  UserModelObject.swift
//  Ingenious.Build.Task
//
//  Created by Makcim Mikhailov on 02/03/2024.
//

import Foundation
import SwiftData

@Model
final class UserModelObject {
    let id: Int
    let login: String
    
    init(id: Int, login: String) {
        self.id = id
        self.login = login
    }
}

extension UserModelObject {
    var toModel: UserModel {
        UserModel(id: id, login: login)
    }
    
    convenience init(from model: UserModel) {
        self.init(id: model.id, login: model.login)
    }
}
