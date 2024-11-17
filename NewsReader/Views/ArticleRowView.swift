//
//  ArticleRowView.swift
//  NewsReader
//
//  Created by Ashu on 17/11/24.
//

import SwiftUI

struct ArticleRowView: View {
    @EnvironmentObject var bookmarkViewModel: BookmarkViewModel
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16, content: {
            if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                        
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        
                    case .failure(_):
                        HStack{
                            Spacer()
                            Image(systemName: "photo")
                                .imageScale(.large)
                            Spacer()
                        }
                        
                    @unknown default:
                        fatalError()
                    }
                }
                .frame(minHeight: 200, maxHeight: 300)
                .background(Color.gray.opacity(0.4))
                .clipped()
            } else {
                Image(systemName: "photo.fill")
                    .imageScale(.large)
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .frame(minHeight: 200, maxHeight: 300)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(3)
                
                Text(article.description ?? "")
                    .font(.subheadline)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                
                HStack {
                    Text(article.sourceAndTimeText)
                        .font(.caption)
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Button {
                        toggleBookmark(for: article)
                    } label: {
                        Image(systemName: bookmarkViewModel.isBookmarked(for: article) ? "bookmark.fill" : "bookmark")
                    }
                    .buttonStyle(.bordered)
                    
                    Button {
                        if let articleURL = URL(string: article.url) {
                            presentShareSeetView(url: articleURL)
                        } else {
//                            Text("Invalid URL")
                        }
                        
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding([.horizontal, .bottom])
            
        })
    }
    
    private func toggleBookmark(for article: Article) {
        if bookmarkViewModel.isBookmarked(for: article) {
            bookmarkViewModel.removeBookmark(article: article)
        } else {
            bookmarkViewModel.addBookmark(article: article)
        }
    }
}

extension View {
    func presentShareSeetView(url: URL) {
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .keyWindow?
            .rootViewController?
            .present(activityViewController, animated: true)
    }
}

#Preview {
    NavigationView {
        List {
            ArticleRowView(article: Article.previewData[12])
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
    }
}
