//
//  WebView.swift
//  WebstoryzSDK
//
//  Created by Евгений Егоров on 12.02.2021.
//

import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    
    let request: URLRequest
    
    let id: UUID = UUID()
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
}

