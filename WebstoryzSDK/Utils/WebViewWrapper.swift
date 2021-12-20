//
//  WebView.swift
//  WebstoryzSDK
//
//  Created by Евгений Егоров on 12.02.2021.
//

import SwiftUI
import WebKit

struct WebViewWrapper : UIViewRepresentable {
    
    let moveNext: () -> Void
    
    let id: UUID = UUID()
    
    let webView: SDKWebView
    
    init(webView:SDKWebView, moveNext: @escaping () -> Void) {
        self.webView = webView
        self.moveNext = moveNext
    }
    
    func makeUIView(context: Context) -> WKWebView  {
        webView.setMoveNext {
            self.moveNext()
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
    
}

class SDKWebView: WKWebView, WKScriptMessageHandler, WKNavigationDelegate {
    
    var moveNext: (() -> Void)?
    
    func setMoveNext(moveNext: @escaping () -> Void) -> Void {
        self.navigationDelegate = self
        if self.moveNext != nil {
            return
        }
        self.moveNext = moveNext
        self.configuration.userContentController = WKUserContentController()
        self.configuration.userContentController.add(self, name: "moving")
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "moveNext" {
            self.moveNext!()
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.cancel)
        if let newURL = navigationAction.request.url, UIApplication.shared.canOpenURL(newURL), !(newURL.absoluteString.contains("apiwidget.webstoryz.com/2.0/widget-story")) {
            UIApplication.shared.open(newURL)
        }
    }
    
}
