//
//  BrowserView.swift
//  NewsReader
//
//  Created by Ashu on 17/11/24.
//

import SwiftUI
import SafariServices

struct BrowserView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> some UIViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}
