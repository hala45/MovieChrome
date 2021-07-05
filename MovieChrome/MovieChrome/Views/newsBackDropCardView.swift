//
//  newsBackDropCardView.swift
//  MovieChrome
//
//  Created by Hala Basyouni on 12/22/20.
//

import SwiftUI

struct newsBackDropCardView: View {
    
    let title: String
    let news: [News]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators : false){
                HStack(alignment: .top, spacing: 16) {
                    ForEach(self.news){ news in
                   
                        NavigationLink(destination: NewsDetailView()) {
                           
                            movieBackDropCard(movie: movie)
                           .frame(width: 272, height: 200)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.leading, movie.id == self.movies.first!.id ?
                                     16:0)
                            .padding(.trailing, movie.id == self.movies.last!.id ?
                                     16:0)
                    }
                }
            }
        }
    }
}

struct MovieBackdropView_previews: PreviewProvider {
    static var previews: some View {
        MovieBackdropView(title: "Now Playing", movies: Movie.stubbedMovies)
    }
   
}



