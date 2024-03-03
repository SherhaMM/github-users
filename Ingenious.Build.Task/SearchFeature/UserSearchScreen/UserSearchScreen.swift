//
//  UserModel.swift
//  Ingenious.Build.Task
//
//  Created by Makcim Mikhailov on 29/02/2024.
//

import SwiftUI

struct UserSearchScreen: View {
    @EnvironmentObject var appContainer: AppDependencyContainer
    @StateObject var viewModel: UserSearchScreenViewModel
    
    var body: some View {
        NavigationStack {
            List(viewModel.users) { user in
                NavigationLink(value: user) {
                    Text(user.login)
                }
            }
                .navigationTitle("Search GitHub User")
                .navigationDestination(for: UserModel.self, destination: { user in
                    UserDetailScreen(viewModel: appContainer.makeUserDetailsViewModel(user: user))
                })
        } 
        .searchable(text: $viewModel.searchQuery)
    }
}

#Preview {
    UserSearchScreen(viewModel: AppDependencyContainer().makeUserSearchViewModel)
}
