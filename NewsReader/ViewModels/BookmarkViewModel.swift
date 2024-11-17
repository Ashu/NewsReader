//
//  BookmarkViewModel.swift
//  NewsReader
//
//  Created by Ashu on 18/11/24.
//

import Foundation
import Combine

class BookmarkViewModel: ObservableObject {
    @Published var bookmarkedArticles: [Article] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    private var bookmarkManager = BookmarkManager()
    
    func loadBookmarks() {
        self.bookmarkedArticles = bookmarkManager.loadBookmarks()
    }
    
    func addBookmark(article: Article) {
        bookmarkManager.addBookmark(article: article)
        loadBookmarks()
    }
    
    func removeBookmark(article: Article) {
        bookmarkManager.removeBookmark(article: article)
        loadBookmarks()
    }
    
    func isBookmarked(for article: Article) -> Bool {
        self.bookmarkedArticles.first { article.id == $0.id } != nil
    }
}
