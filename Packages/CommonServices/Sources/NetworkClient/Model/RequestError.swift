//
//  HTTPClient.swift
//
//
//  Created by Makcim Mikhailov on 10/10/2023.
//

public enum RequestError: Error {
    case decode
    case bodySerialization
    case invalidURL
    case noResponse
    case unauthorized
    case redirection
    case unknown
    case generic(localizedDescription: String)
}
