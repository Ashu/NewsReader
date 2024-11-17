//
//  NewsTabView.swift
//  NewsReader
//
//  Created by Ashu on 18/11/24.
//

import SwiftUI

struct NewsTabView: View {
    var body: some View {
        NavigationView {
            ArticleListView()
                .navigationTitle("Top Headlines")
        }
    }
}

#Preview {
    NewsTabView()
}
