//
//  HTTPClient.swift
//
//
//  Created by Makcim Mikhailov on 10/10/2023.
//

import Foundation
import Combine

public protocol HTTPClientServicing {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseType: T.Type) async throws -> T
}

public protocol ClientProtocol {
    func data(for request: URLRequest, delegate: (URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}

extension URLSession: ClientProtocol { }

open class HTTPClient: HTTPClientServicing {
    private let host: String
    private let client: ClientProtocol
    
    public init(client: ClientProtocol, host: String) {
        self.client = client
        self.host = host
    }

    public func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseType: T.Type
    ) async throws -> T {
        do {
            let request = try makeRequest(for: endpoint)
            let (data, response) = try await client.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                throw RequestError.noResponse
            }

            if let error = verifyStatusCode(response.statusCode) {
                throw error
            }

            guard let decodedResponse = try? JSONDecoder().decode(responseType, from: data) else {
                throw RequestError.decode
            }

            return decodedResponse
        } catch let error as RequestError {
            print("Error on sendRequest: \(error)\n\(error.localizedDescription)")
            throw error
        }
    }

    private func makeRequest(for endpoint: Endpoint) throws -> URLRequest {
        guard let url = endpoint.makeURL(host: host) else {
            throw RequestError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        var baseHeader = [String: String]()
        if let customHeaders = endpoint.header {
            baseHeader.merge(customHeaders, uniquingKeysWith: {(l,_) in l})
        }
        request.allHTTPHeaderFields = baseHeader
        if let body = endpoint.body {
            guard let serializedBody = try? JSONSerialization.data(withJSONObject: body) else {
                throw RequestError.bodySerialization
            }
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = serializedBody
        }
        return request
    }

    private func verifyStatusCode(_ code: Int) -> RequestError? {
        switch code {
        case 200...299: return nil
        case 302: return .redirection
        case 401: return .unauthorized
        default: return .unknown
        }
    }
}
