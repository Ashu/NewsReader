//
//  ArticlesViewModel.swift
//  NewsReader
//
//  Created by Ashu on 17/11/24.
//

import Foundation
import SwiftUI
import Combine


enum ResultState {
    case loading
    case failure(error: Error)
    case success(content: [Article])
}

class ArticlesViewModel: ObservableObject {
    @Published private(set) var state: ResultState = .loading
    
    private var cancellables = Set<AnyCancellable>()
    private let networkManager: NetworkManager
    
    private(set) var articles = [Article]()
    
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetchTopHeadlines() {
        self.state = .loading
        let endpoint = NewsAPIEndpoint.topHeadlines
        
        networkManager.request(from: endpoint)
            .sink { result in
                switch result {
                case .finished:
                    self.state = .success(content: self.articles)
                case .failure(let error):
                    self.state = .failure(error: error)
                }
            } receiveValue: { resposne in
                self.articles = resposne.articles ?? []
            }
            .store(in: &cancellables)
    }
    
    func fetchArticles(forCategory category: String) {
        self.state = .loading
        let endpoint = NewsAPIEndpoint.category(category)
        
        networkManager.request(from: endpoint)
            .sink { result in
                switch result {
                case .finished:
                    self.state = .success(content: self.articles)
                case .failure(let error):
                    self.state = .failure(error: error)
                }
            } receiveValue: { response in
                self.articles = response.articles ?? []
            }
            .store(in: &cancellables)
    }
    

}
