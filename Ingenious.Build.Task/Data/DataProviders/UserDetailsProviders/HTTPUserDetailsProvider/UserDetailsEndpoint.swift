//
//  UserDetailsEndpoint.swift
//  Ingenious.Build.Task
//
//  Created by Makcim Mikhailov on 02/03/2024.
//

import Foundation
import NetworkClient

enum UserDetailsEndpoint: Endpoint {
    case getUserDetails(login: String)
    
    var path: String {
        switch self {
        case .getUserDetails(login: let login): return "/users/\(login)"
        }
    }
    
    var method: NetworkClient.RequestMethod {
        switch self {
        case .getUserDetails(login: _): return .get
        }
    }
    
    var header: [String : String]? { nil}
    
    var body: [String : String]? { nil }
    
    var queryItems: [String : String?]? { nil}
    
}
