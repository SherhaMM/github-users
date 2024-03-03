//
//  HTTPUserDetailsProvider.swift
//  Ingenious.Build.Task
//
//  Created by Makcim Mikhailov on 29/02/2024.
//

import Foundation
import NetworkMonitor

final class HTTPUserDetailsProvider: UserDetailsProviding {
    private let apiClient: AppHTTPClient
    private let networkMonitor: NetworkMonitoring
    
    init(apiClient: AppHTTPClient, networkMonitor: NetworkMonitoring) {
        self.apiClient = apiClient
        self.networkMonitor = networkMonitor
    }
    
    func getUserDetails(by login: String) async -> UserDetailsModel? {
        guard networkMonitor.networkStatus else {
            print("Network isn't reachable")
            return nil
        }
        
        let endpoint = UserDetailsEndpoint.getUserDetails(login: login)
        let result = try? await apiClient.sendRequest(endpoint: endpoint, responseType: UserDetailsModel.self)
        // Errors handling is out of scope for this task
        return result
    }
    
}
