//
//  UserDetailsProviding.swift
//  Ingenious.Build.Task
//
//  Created by Makcim Mikhailov on 02/03/2024.
//

import Foundation

protocol UserDetailsProviding {
    func getUserDetails(by login: String) async -> UserDetailsModel?
}
