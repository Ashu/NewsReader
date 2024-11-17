//
//  ArticleListView.swift
//  NewsReader
//
//  Created by Ashu on 17/11/24.
//

import SwiftUI

struct ArticleListView: View {
    @StateObject private var articleViewModel: ArticlesViewModel
    
    init(viewModel: ArticlesViewModel = ArticlesViewModel()) {
        _articleViewModel = StateObject(wrappedValue: viewModel)
    }
    
    @State private var selectedArticle: Article?
    
    var body: some View {
        Group {
            switch articleViewModel.state {
            case .loading:
                ProgressView()
            case .failure(let error):
                VStack {
                    Text("An error occurred:")
                        .font(.headline)
                    Text(error.localizedDescription)
                        .font(.subheadline)
                        .foregroundColor(.red)
                    Button("Retry") {
                        articleViewModel.fetchTopHeadlines()
                    }
                    .padding(.top)
                }
                .padding()
                
            case .success(let articles):
                List {
                    ForEach(articles) { article in
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
            }
        }
        .onAppear(perform: {
            articleViewModel.fetchTopHeadlines()
        })
    }
}

#Preview {
    ArticleListView()
}
