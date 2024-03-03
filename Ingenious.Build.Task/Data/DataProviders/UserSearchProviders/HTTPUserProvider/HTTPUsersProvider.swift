//
//  APIUsersProvider.swift
//  Ingenious.Build.Task
//
//  Created by Makcim Mikhailov on 29/02/2024.
//

import Foundation
import NetworkMonitor

final class HTTPUsersProvider: UserSearchProviding {
    private let apiClient: AppHTTPClient
    private let networkMonitor: NetworkMonitoring
    
    init(apiClient: AppHTTPClient, networkMonitor: NetworkMonitoring) {
        self.apiClient = apiClient
        self.networkMonitor = networkMonitor
    }
    
    func getUsers(by query: String) async -> [UserModel] {
        guard networkMonitor.networkStatus else {
            print("Network isn't reachable")
            return []
        }
        
        let endpoint = UserSearchEndpoint.getUsersByName(query: query)
        let result = try? await apiClient.sendRequest(endpoint: endpoint, responseType: SearchUserModel.self).users
        // Errors handling is out of scope for this task
        return result ?? []
    }
    
}
