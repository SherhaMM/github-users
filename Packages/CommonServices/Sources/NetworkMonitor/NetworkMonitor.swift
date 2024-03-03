//
//  NetworkMonitor.swift
//  
//
//  Created by Makcim Mikhailov on 02/03/2024.
//

import Foundation
import Network
import Combine

public protocol NetworkMonitoring {
    var networkStatus: Bool { get }
}

final public class NetworkMonitor: NetworkMonitoring {
    public var networkStatus: Bool = true
    
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    public init() {
        monitor = NWPathMonitor()
        startMonitoring()
    }
    
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.networkStatus = true
            } else {
                self?.networkStatus = false
            }
        }
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
    }
    
}
