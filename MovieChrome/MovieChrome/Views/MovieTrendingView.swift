//
//  MovieTrendingView.swift
//  MovieChrome
//
//  Created by Hala Basyouni on 12/22/20.
//

import SwiftUI

struct MovieTrendingView: View {
    
    @ObservedObject private var trendingStateWeek = MovieTrendingState()
    @ObservedObject private var trendingStateDay = MovieTrendingState()
    @ObservedObject private var GermanyState = MovieTrendingState()
    @ObservedObject private var ItalyState = MovieTrendingState()
    //@ObservedObject private var KoreaState = MovieTrendingState()
    @ObservedObject private var FranceState = MovieTrendingState()
    @ObservedObject private var UKState = MovieTrendingState()
    @ObservedObject private var IndiaState = MovieTrendingState()
    @ObservedObject private var EgyptState = MovieTrendingState()

    
    var body: some View {
        NavigationView {
            List {
                Group {
                    if trendingStateWeek.movies != nil {
                        MovieBackdropView(title: "This Week", movies: trendingStateWeek.movies!)
                        
                    } else {
                        LoadingView(isLoading: self.trendingStateWeek.isLoading, error: self.trendingStateWeek.error) {
                            self.trendingStateWeek.loadTrendingMoviesByWeek()
                        }
                    }
                    
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                Group {
                    if trendingStateDay.movies != nil {
                        MovieBackdropView(title: "This Day", movies: trendingStateDay.movies!)
                        
                    } else {
                        LoadingView(isLoading: self.trendingStateDay.isLoading, error: self.trendingStateDay.error) {
                            self.trendingStateDay.loadTrendingMoviesByDay()
                        }
                    }
                    
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                Group {
                    if UKState.movies != nil {
                        MovieBackdropView(title: "In UK", movies: UKState.movies!)
                        
                    } else {
                        LoadingView(isLoading: self.UKState.isLoading, error: self.UKState.error) {
                            self.UKState.loadTrendingMoviesByUK()
                        }
                    }
                    
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                Group {
                    if FranceState.movies != nil {
                        MovieBackdropView(title: "In France", movies: FranceState.movies!)
                        
                    } else {
                        LoadingView(isLoading: self.FranceState.isLoading, error: self.FranceState.error) {
                            self.FranceState.loadTrendingMoviesByFrance()
                        }
                    }
                    
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                Group {
                    if ItalyState.movies != nil {
                        MovieBackdropView(title: "In Italy", movies: ItalyState.movies!)
                        
                    } else {
                        LoadingView(isLoading: self.ItalyState.isLoading, error: self.ItalyState.error) {
                            self.ItalyState.loadTrendingMoviesByItaly()
                        }
                    }
                    
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                Group {
                    if EgyptState.movies != nil {
                        MovieBackdropView(title: "In Egypt", movies: EgyptState.movies!)
                        
                    } else {
                        LoadingView(isLoading: self.EgyptState.isLoading, error: self.EgyptState.error) {
                            self.EgyptState.loadTrendingMoviesByEgypt()
                        }
                    }
                    
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                Group {
                    if IndiaState.movies != nil {
                        MovieBackdropView(title: "In India", movies: IndiaState.movies!)
                        
                    } else {
                        LoadingView(isLoading: self.IndiaState.isLoading, error: self.IndiaState.error) {
                            self.IndiaState.loadTrendingMoviesByIndia()
                        }
                    }
                    
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                Group {
                    if GermanyState.movies != nil {
                        MovieBackdropView(title: "In Germany", movies: GermanyState.movies!)
                        
                    } else {
                        LoadingView(isLoading: self.GermanyState.isLoading, error: self.GermanyState.error) {
                            self.GermanyState.loadTrendingMoviesByGermany()
                        }
                    }
                    
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                
                
                
           
        }
        .onAppear {
            self.trendingStateWeek.loadTrendingMoviesByWeek()
            self.trendingStateDay.loadTrendingMoviesByDay()
            self.UKState.loadTrendingMoviesByUK()
            self.FranceState.loadTrendingMoviesByFrance()
            self.ItalyState.loadTrendingMoviesByItaly()
            self.EgyptState.loadTrendingMoviesByEgypt()
            self.IndiaState.loadTrendingMoviesByIndia()
            self.GermanyState.loadTrendingMoviesByGermany()
            //self.KoreaState.loadTrendingMoviesByKorea()
            
            
         
        }
            .navigationBarTitle("Trending")
            
       
    
    }
  }
    
}
struct MovieTrendingView_Previews: PreviewProvider {
    static var previews: some View {
        MovieTrendingView()
    }
}


