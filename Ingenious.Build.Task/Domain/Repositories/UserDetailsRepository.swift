//
//  UserDetailsRepository.swift
//  Ingenious.Build.Task
//
//  Created by Makcim Mikhailov on 01/03/2024.
//

import Foundation

final class UserDetailsRepository {
    private let userDetailsProvider: UserDetailsProviding
    private let userDetailsStore: UserDetailsStoring
    
    init(userDetailsProvider: UserDetailsProviding, userDetailsStore: UserDetailsStoring) {
        self.userDetailsProvider = userDetailsProvider
        self.userDetailsStore = userDetailsStore
    }
    
    func getCachedUserDetails(login: String) async -> UserDetailsModel? {
        return userDetailsStore.getUser(by: login)
    }
    
    func fetchUserDetails(by login: String) async -> UserDetailsModel? {
        guard let user = await userDetailsProvider.getUserDetails(by: login) else { return nil }
        userDetailsStore.saveUser(user)
        return user
    }
}
