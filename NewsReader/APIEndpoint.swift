//
//  APIEndpoint.swift
//  NewsReader
//
//  Created by Ashu on 16/11/24.
//

import Foundation

protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var url: URL? { get }
}

extension APIEndpoint {
    var url: URL? {
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        components?.path.append(path)
        components?.queryItems = (queryItems)
        return components?.url
    }
}

enum NewsAPIEndpoint: APIEndpoint {
    case topHeadlines
    case category(String)
    
    var baseURL: URL {
        URL(string: "https://newsapi.org/v2")!
    }
    
    var path: String {
        switch self {
        case .topHeadlines, .category:
            return "/top-headlines"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
            
        case .topHeadlines:
            return [
            URLQueryItem(name: "country", value: "us")
            ]
            
        case .category(let category):
            return [
                URLQueryItem(name: "country", value: "us"),
                URLQueryItem(name: "category", value: category)
            ]
        }
    }
}
