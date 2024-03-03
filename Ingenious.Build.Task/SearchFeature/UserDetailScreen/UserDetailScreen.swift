//
//  UserDetailScreen.swift
//  Ingenious.Build.Task
//
//  Created by Makcim Mikhailov on 02/03/2024.
//

import Foundation
import SwiftUI

struct UserDetailScreen: View {
    @StateObject var viewModel: UserDetailViewModel
    
    var body: some View {
        Group {
            if let userDetails = viewModel.userDetail {
                userDetailsLoadedView(userDetails)
            } else {
                ProgressView()
            }
        }
        .task {
            await viewModel.fetchUserDetailsFromCacheAndNetwork()
        }
        .navigationTitle("Profile Details")
    }
    
    func userDetailsLoadedView(_ details: UserDetailsModel) -> some View {
        List {
            userAvatarView(avatarUrl: details.avatarUrl)
            LabeledContent("Login", value: details.login)
            if let name = details.name {
                LabeledContent("Name", value: name)
            }
            if let bio = details.bio {
                LabeledContent("Bios", value: bio)
            }
            if let company = details.company {
                LabeledContent("Company", value: company)
            }
        }
    }
    
    func userAvatarView(avatarUrl: String) -> some View {
        HStack {
            Spacer()
            AsyncImage(url: URL(string: avatarUrl)) { image in
                image.resizable()
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        UserDetailScreen(viewModel: AppDependencyContainer().makeUserDetailsViewModel(user: UserModel(id: 1, login: "max")))
    }
}

