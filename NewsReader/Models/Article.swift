//
//  Article.swift
//  NewsReader
//
//  Created by Ashu on 16/11/24.
//

import Foundation

struct NewsResponse: Decodable {
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    
    let code: String?
    let message: String?
}

struct Source: Codable {
    let id: String?
    let name: String?
}

struct Article: Codable, Identifiable, Equatable {
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: String { url }
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage:String?
    let publishedAt: Date
    let content: String?
    
    var sourceAndTimeText: String {
        "\(source.name ?? "") · \(RelativeDateTimeFormatter().localizedString(for: publishedAt, relativeTo: Date()))"
    }
}

extension Article {
    
    static var dummyData: Article {
        .init(source: Source(id: "the-washington-post", name: "The Washington Post"), author: "Andrew Jeong", title: "Surge in worldwide measles cases driven by lack of vaccine coverage, WHO says - The Washington Post", description: "The WHO and CDC say there were about 10.3 million cases of measles last year, up 20 percent from 2022. Children are especially susceptible to complications.", url: "https://www.washingtonpost.com/health/2024/11/15/measles-vaccine-immunization-cdc-rfk/", urlToImage: "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://arc-anglerfish-washpost-prod-washpost.s3.amazonaws.com/public/WLLDNHUDDDPWGNHBSQBM7X6QSY_size-normalized.jpg&w=1440", publishedAt: Date(), content: "An estimated 10.3 million cases of measles occurred worldwide last year, up 20 percent from 2022, primarily because of inadequate immunization coverage, the World Health Organization and the U.S. Cen… [+386 chars]")
    }
    static var previewData: [Article] {
        
        guard let previewDataURL = Bundle.main.url(forResource: "news", withExtension: "json") else { return [] }
        let data = try! Data(contentsOf: previewDataURL)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        let apiResponse = try! jsonDecoder.decode(NewsResponse.self, from: data)
        
        return apiResponse.articles ?? []
    }
}
