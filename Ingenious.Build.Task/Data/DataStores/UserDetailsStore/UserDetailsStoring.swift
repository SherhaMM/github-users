//
//  UserDetailsStoring.swift
//  Ingenious.Build.Task
//
//  Created by Makcim Mikhailov on 02/03/2024.
//

import Foundation

protocol UserDetailsStoring {
    func saveUser(_ users: UserDetailsModel)
    func getUser(by login: String) -> UserDetailsModel?
}
