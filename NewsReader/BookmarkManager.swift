//
//  BookmarkManager.swift
//  NewsReader
//
//  Created by Ashu on 18/11/24.
//

import Foundation

class BookmarkManager {
    private let key = "bookmarkedArticles"
    
    func loadBookmarks() -> [Article] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let articles = try? JSONDecoder().decode([Article].self, from: data) else {
            return []
        }
        return articles
    }
    
    func addBookmark(article: Article) {
        var articles = loadBookmarks()
        articles.append(article)
        saveBookmarks(articles)
    }
    
    private func saveBookmarks(_ articles: [Article]) {
        if let data = try? JSONEncoder().encode(articles) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func removeBookmark(article: Article) {
        var articles = loadBookmarks()
        articles.removeAll { $0.id == article.id }
        saveBookmarks(articles)
    }
}
