//
//  ContentView.swift
//  NewsReader
//
//  Created by Ashu on 16/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NewsTabView()
                .tabItem { Label("News", systemImage: "newspaper") }
            
            BookmarkView()
                .tabItem { Label("Bookmarks", systemImage: "bookmark") }
        }
    }
}

#Preview {
    ContentView()
}
