//
//  AppDependecyContainer.swift
//  Ingenious.Build.Task
//
//  Created by Makcim Mikhailov on 01/03/2024.
//

import Foundation
import NetworkMonitor
import SwiftUI
import SwiftData
import NetworkClient

@MainActor
final class AppDependencyContainer: ObservableObject {
    private let modelContainer: ModelContainer
    
    private lazy var httpClient: AppHTTPClient = {
        Self.makeHTTPClient()
    }()
    
    private lazy var networkMonitor: NetworkMonitoring = {
        Self.makeNetworkMonitor()
    }()
    
    init() {
        self.modelContainer = Self.makeSharedModelContainer()
    }
    
    // MARK: - Bulding UserSearchViewModel
    var makeUserSearchViewModel: UserSearchScreenViewModel {
        UserSearchScreenViewModel(userRepository: makeUserSearchRepository)
    }
    
    var makeUserSearchRepository: UserSearchRepository {
        UserSearchRepository(userProvider: makeUserSearchProvider, userStore: makUserSearchResultsStore)
    }
    
    var makeUserSearchProvider: UserSearchProviding {
        HTTPUsersProvider(apiClient: httpClient, networkMonitor: networkMonitor)
    }
    
    var makUserSearchResultsStore: UserSearchResultsStoring {
        DBUserSearchResultsStore(modelContext: modelContainer.mainContext)
    }
    
    // MARK: - Bulding UserDetailsViewModel
    func makeUserDetailsViewModel(user: UserModel) -> UserDetailViewModel {
        UserDetailViewModel(user: user, userDetailsRepo: makeUserDetailsRepository)
    }
    
    var makeUserDetailsRepository: UserDetailsRepository {
        UserDetailsRepository(userDetailsProvider: makeUserDetailsProvider, userDetailsStore: makeUserDetailsStore)
    }
    
    var makeUserDetailsProvider: UserDetailsProviding {
        HTTPUserDetailsProvider(apiClient: httpClient, networkMonitor: networkMonitor)
    }
    
    var makeUserDetailsStore: UserDetailsStoring {
        DBUserDetailsStore(modelContext: modelContainer.mainContext)
    }
    // MARK: - Private Bulding Dependency Container
    private static func makeSharedModelContainer() -> ModelContainer {
        let schema = Schema([
            UserModelObject.self,
            SearchSuggestionObject.self,
            UserDetailsObject.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        guard let modelContainer = try? ModelContainer(for: schema, configurations: [modelConfiguration]) else {
            fatalError("DB couldn't be instantiated")
        }
        return modelContainer
    }
    
    private static func makeNetworkMonitor() -> NetworkMonitoring {
        NetworkMonitor()
    }
    
    private static func makeHTTPClient() -> AppHTTPClient {
        AppHTTPClient(host: "api.github.com")
    }
    
}
