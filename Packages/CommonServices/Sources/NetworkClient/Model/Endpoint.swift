//
//  HTTPClient.swift
//
//
//  Created by Makcim Mikhailov on 10/10/2023.
//

import Foundation

public protocol Endpoint {
    var scheme: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var queryItems: [String: String?]? { get }
}

public extension Endpoint {
    var scheme: String {
        "https"
    }
    
    func makeQueryItems() -> [URLQueryItem] {
        queryItems?.map { URLQueryItem(name: $0.key, value: $0.value) } ?? []
    }
}

public extension Endpoint {
    func makeURL(host: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = makeQueryItems()
        return urlComponents.url
    }
}
