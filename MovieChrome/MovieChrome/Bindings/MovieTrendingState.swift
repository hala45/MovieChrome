//
//  MovieTrendingState.swift
//  MovieChrome
//
//  Created by Hala Basyouni on 12/22/20.
//

import SwiftUI

class MovieTrendingState: ObservableObject {
    
    @Published var movies: [Movie]?
    @Published var isLoading: Bool = false
    @Published var error: NSError?

    private let movieService: MovieService
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    func loadTrendingMoviesByWeek() {
        self.movies = nil
        self.isLoading = true
        self.movieService.trendingMoviesWeek{ [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.movies = response.results
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    func loadTrendingMoviesByDay() {
        self.movies = nil
        self.isLoading = true
        self.movieService.trendingMoviesDay{ [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.movies = response.results
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    

    func loadTrendingMoviesByFrance() {
        self.movies = nil
        self.isLoading = true
        self.movieService.trendingMoviesFrance{ [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.movies = response.results
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    func loadTrendingMoviesByUK() {
        self.movies = nil
        self.isLoading = true
        self.movieService.trendingMoviesUK{ [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.movies = response.results
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    func loadTrendingMoviesByItaly() {
        self.movies = nil
        self.isLoading = true
        self.movieService.trendingMoviesItaly{ [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.movies = response.results
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    func loadTrendingMoviesByEgypt() {
        self.movies = nil
        self.isLoading = true
        self.movieService.trendingMoviesEgypt{ [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.movies = response.results
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    func loadTrendingMoviesByIndia() {
        self.movies = nil
        self.isLoading = true
        self.movieService.trendingMoviesIndia{ [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.movies = response.results
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    func loadTrendingMoviesByGermany() {
        self.movies = nil
        self.isLoading = true
        self.movieService.trendingMoviesGermany{ [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.movies = response.results
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
}



