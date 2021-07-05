//
//  MovieDetailView.swift
//  MovieChrome
//
//  Created by Hala Basyouni on 11/18/20.
//

import SwiftUI
import UIKit
import SafariServices
import WebKit
import Foundation

struct MovieDetailView: View {
    
    let movieId: Int
    @ObservedObject private var movieDetailState = MovieDetailState()
    
    var body: some View {
        ZStack {
            LoadingView(isLoading: self.movieDetailState.isLoading, error: self.movieDetailState.error) {
                self.movieDetailState.loadMovie(id: self.movieId)
            }
            
            if movieDetailState.movie != nil {
                WebView(movie: self.movieDetailState.movie!)
                
            }
        }
        
        .onAppear {
            self.movieDetailState.loadMovie(id: self.movieId)
        }
    }
}




struct WebView: UIViewRepresentable {
    
  
    let movie : Movie

    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        let webView = WKWebView()
       
        webView.load(URLRequest(url: movie.detailsURL))
        webView.allowsBackForwardNavigationGestures = false
        return webView
    }
        
            
        

    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {

    }
}
   

  


    

