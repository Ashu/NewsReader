//
//  NetworkManager.swift
//  NewsReader
//
//  Created by Ashu on 16/11/24.
//

import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    private func buildRequest(from endpoint: APIEndpoint) -> URLRequest? {
        guard var url = endpoint.url else { return nil }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems?.append(URLQueryItem(name: "apiKey", value: APIConfig.apiKey))
        if let updatedURL = components?.url {
            url = updatedURL
        }
        
        return URLRequest(url: url)
    }
    
    func request(from endpoint: APIEndpoint) -> AnyPublisher<NewsResponse, NetworkError> {
        
        guard let request = buildRequest(from: endpoint) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.serverError("Invalid response for the server.")
                }
                return result.data
            }
            .decode(type: NewsResponse.self, decoder: decoder)
            .mapError { error -> NetworkError in
                if let decodingError = error as? DecodingError {
                    return .decodingFailed
                } else {
                    return .unknown(error)
                }
                
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
