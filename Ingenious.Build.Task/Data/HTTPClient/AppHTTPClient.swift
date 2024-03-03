//
//  AppApiClient.swift
//  Ingenious.Build.Task
//
//  Created by Makcim Mikhailov on 01/03/2024.
//

import Foundation
import NetworkClient

final class AppHTTPClient: HTTPClient {
    init(host: String) {
        super.init(client: URLSession.shared, host: host)
    }
}
