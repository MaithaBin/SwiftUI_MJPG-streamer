//
//  StreamView.swift
//  SwiftUI_MJPG-streamer
//
//  Created by admin on 2024/01/11.
//

import SwiftUI
import WebKit

struct StreamView: UIViewRepresentable {
    let url: String
    
    /// Creates the view object.
    /// This method is only invoked once.
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    /// Updates the view object.
    /// This method is called and updates the view when the current state changes.
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: url) else {
            return
        }
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
