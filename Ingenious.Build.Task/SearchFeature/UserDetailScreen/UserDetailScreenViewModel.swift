//
//  UserDetailScreenViewModel.swift
//  Ingenious.Build.Task
//
//  Created by Makcim Mikhailov on 03/03/2024.
//

import Foundation

@MainActor
final class UserDetailViewModel: ObservableObject {
    // MARK: - DI
    private let userDetailsRepo: UserDetailsRepository
    
    // MARK: - Variables
    let user: UserModel
    @Published var userDetail: UserDetailsModel? = nil
    
    init(user: UserModel, userDetailsRepo: UserDetailsRepository) {
        self.user = user
        self.userDetailsRepo = userDetailsRepo
    }
    
    func fetchUserDetailsFromCacheAndNetwork() async {
        print("Fetch user details called")
        async let fetchedDetails = userDetailsRepo.fetchUserDetails(by: user.login)
        userDetail = await userDetailsRepo.getCachedUserDetails(login: user.login)
        userDetail = await fetchedDetails
    }
}
