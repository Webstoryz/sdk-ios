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
    let moveNext: () -> Void
    
    let id: UUID = UUID()
    
    let webView = SDKWebView()
    
    func makeUIView(context: Context) -> WKWebView  {
        webView.setMoveNext {
            self.moveNext()
        }
        webView.load(request)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
    
}

class SDKWebView: WKWebView, WKScriptMessageHandler {
    
    var moveNext: () -> Void = {}
    
    func setMoveNext(moveNext: @escaping () -> Void) -> Void {
        self.moveNext = moveNext
        self.configuration.userContentController = WKUserContentController()
        self.configuration.userContentController.add(self, name: "moving")
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "moveNext" {
            self.moveNext()
        }
    }
}
