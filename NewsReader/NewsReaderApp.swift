//
//  NewsReaderApp.swift
//  NewsReader
//
//  Created by Ashu on 16/11/24.
//

import SwiftUI

@main
struct NewsReaderApp: App {
    @StateObject var bookmarkViewModel = BookmarkViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bookmarkViewModel)
        }
    }
}
