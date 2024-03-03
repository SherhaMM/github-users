//
//  Ingenious_Build_TaskApp.swift
//  Ingenious.Build.Task
//
//  Created by Makcim Mikhailov on 29/02/2024.
//

import SwiftUI
import SwiftData

@main
struct Ingenious_Build_TaskApp: App {
    @MainActor
    private var appContainer = AppDependencyContainer()
    
    var body: some Scene {
        WindowGroup {
            UserSearchScreen(viewModel: appContainer.makeUserSearchViewModel)
                .environmentObject(appContainer)
        }
    }
}
