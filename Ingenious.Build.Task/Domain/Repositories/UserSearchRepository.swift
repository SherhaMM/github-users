//
//  UserRepository.swift
//  Ingenious.Build.Task
//
//  Created by Makcim Mikhailov on 01/03/2024.
//

import Foundation

final class UserSearchRepository {
    private let userSearchProvider: UserSearchProviding
    private let userSearchResultsStore: UserSearchResultsStoring
    
    init(userProvider: UserSearchProviding, userStore: UserSearchResultsStoring) {
        self.userSearchProvider = userProvider
        self.userSearchResultsStore = userStore
    }
    
    func fetchUsers(by query: String) async -> [UserModel] {
        let users = await userSearchProvider.getUsers(by: query)
        userSearchResultsStore.saveSearchResults(users)
        return users
    }
}
