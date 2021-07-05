//
//  ContentView.swift
//  MovieChrome
//
//  Created by Hala Basyouni on 9/28/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MovieListView()
                .tabItem{
                    VStack{
                        Image(systemName:"play.rectangle")
                        Text("Movies")
                    }
                }
                .tag(0)
            MovieSearchView()
                .tabItem{
                    VStack{
                        Image(systemName:"magnifyingglass")
                        Text("Search")
                    }
                }
                .tag(1)
            NewsView()
                .tabItem{
                    VStack{
                        Image(systemName:"bubble.left.and.bubble.right")
                        Text("News")
                    }
                }
                .tag(2)
            MovieTrendingView()
                .tabItem{
                    VStack{
                        Image(systemName:"arrow.up.forward")
                        Text("Trending")
                    }
                }
                .tag(3)
          
        }
        .onAppear(){
            UITabBar.appearance().barTintColor = .white
        }
        .accentColor(.blue)
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
           
        }
    }
}
