//
//  BookmarkView.swift
//  NewsReader
//
//  Created by Ashu on 18/11/24.
//

import SwiftUI

struct BookmarkView: View {
    @StateObject private var bookmarkViewModel = BookmarkViewModel()
    @State private var selectedArticle: Article?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(bookmarkViewModel.bookmarkedArticles) { article in
                    ArticleRowView(article: article)
                        .onTapGesture {
                            selectedArticle = article
                        }
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .sheet(item: $selectedArticle) {
                if let url = URL(string: $0.url) {
                    BrowserView(url: url)
                        .edgesIgnoringSafeArea(.bottom)
                } else {
                    Text("Invalid URL")
                }
            }
            .navigationTitle("Bookmarked Articles")
            .onAppear {
                bookmarkViewModel.loadBookmarks()
            }
        }
    }
}

#Preview {
    BookmarkView()
}
