//
//  UserProviding.swift
//  Ingenious.Build.Task
//
//  Created by Makcim Mikhailov on 29/02/2024.
//

import Foundation

protocol UserSearchProviding {
    func getUsers(by query: String) async -> [UserModel]
}
