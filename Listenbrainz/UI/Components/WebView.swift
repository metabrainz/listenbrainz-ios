//
//  WebView.swift
//  Listenbrainz
//
//  Created by Jasjeet Singh on 16/04/25.
//

import SwiftUI
import WebKit

struct WebViewLB: UIViewRepresentable {
    let url: URL
    var onFinishLoading: ((WKWebView) -> Void)? = nil
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onFinishLoading: onFinishLoading)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        // Use a non-persistent data store
        config.websiteDataStore = .nonPersistent()
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var onFinishLoading: ((WKWebView) -> Void)?
        
        init(onFinishLoading: ((WKWebView) -> Void)?) {
            self.onFinishLoading = onFinishLoading
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            onFinishLoading?(webView)
        }
    }
}
