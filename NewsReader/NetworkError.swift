//
//  NetworkError.swift
//  NewsReader
//
//  Created by Ashu on 17/11/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case decodingFailed
    case serverError(String)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
            
        case .decodingFailed:
            return "Failed to decode the response."
            
        case .serverError(let message):
            return "Server error: \(message)"
            
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
