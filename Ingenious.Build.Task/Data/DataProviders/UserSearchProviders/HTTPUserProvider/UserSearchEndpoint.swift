//
//  UsersEnpoint.swift
//  Ingenious.Build.Task
//
//  Created by Makcim Mikhailov on 01/03/2024.
//

import Foundation
import NetworkClient

enum UserSearchEndpoint: Endpoint {
    case getUsersByName(query: String)
    
    var path: String {
        switch self {
        case .getUsersByName: return "/search/users"
        }
    }
    
    var method: RequestMethod { 
        switch self {
        case .getUsersByName(query: _): return .get
        }
    }
    
    var header: [String : String]? { nil }
    
    var body: [String : String]? { nil }
    
    var queryItems: [String : String?]? {
        switch self {
        case .getUsersByName(let query): ["q": query]
        }
    }
}
