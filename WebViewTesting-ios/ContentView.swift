//
//  ContentView.swift
//  WebViewTesting-ios
//
//  Created by Oren Zakay on 13/09/2020.
//  Copyright © 2020 Oren Zakay. All rights reserved.
//

import SwiftUI
import WebKit

struct ContentView: View {
  @ObservedObject var webViewStore = WebViewStore()
  let indexURL = Bundle.main.url(forResource: "testing", withExtension: "html")!
  var body: some View {
    NavigationView {
      WebView(webView: webViewStore.webView)
        .navigationBarTitle(Text(verbatim: webViewStore.webView.title ?? "WebViewTesting"), displayMode: .inline)
        .navigationBarItems(trailing: HStack {
          Button(action: goBack) {
            Image(systemName: "chevron.left")
              .imageScale(.large)
              .aspectRatio(contentMode: .fit)
              .frame(width: 32, height: 32)
          }.disabled(!webViewStore.webView.canGoBack)
          Button(action: goForward) {
            Image(systemName: "chevron.right")
              .imageScale(.large)
              .aspectRatio(contentMode: .fit)
              .frame(width: 32, height: 32)
          }.disabled(!webViewStore.webView.canGoForward)
        })
        .accessibility(label: Text("Shono"))
    }.onAppear {
//      self.webViewStore.webView.load(URLRequest(url: URL(string: "https://apple.com")!))
        self.webViewStore.webView.loadFileURL(self.indexURL, allowingReadAccessTo: self.indexURL)
    }
  }
  
//    var body: some View {
//        Button(action: {
//            print("Button is tapped")
//        }){
//            Text("Tap Me")
//        }
//    }

  
  func goBack() {
    webViewStore.webView.goBack()
  }
  
  func goForward() {
    webViewStore.webView.goForward()
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
