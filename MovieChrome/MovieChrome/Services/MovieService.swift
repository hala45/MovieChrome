//
//  MovieServices .swift
//  MovieChrome
//
//  Created by Hala Basyouni on 9/28/20.
//

import Foundation

protocol MovieService {
    //fetching the movies sections on the homepage and point enum as the param, the param also accepts an escaping closure using the swift result type and the type of success data is movie response and the error is the movie error enum
    func fetchMovies(from endpoint: MovieListEndpoint, completion:@escaping (Result<MovieResponse,MovieError>)->())
    
    //fetching a single movie using the id the type of success data is the movie itself and the error is calling the error enum (for the imdb page)
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>)->())
        
    //searching movies when given a query string(movie) as the param the type of success data(completion closure)
    func searchMovie(query:String, completion:@escaping (Result<MovieResponse, MovieError>)->())
    //trending movies for the week
    func trendingMoviesWeek(completion: @escaping (Result<MovieResponse, MovieError>)->())
    
    //trending movies for the day
    func trendingMoviesDay(completion: @escaping (Result<MovieResponse, MovieError>)->())
    //trending movies in germany
    func trendingMoviesGermany(completion: @escaping (Result<MovieResponse1, IDError>)->())
    //trending movies in Italy
    func trendingMoviesItaly(completion: @escaping (Result<MovieResponse1, IDError>)->())
    //trending movies in France
    func trendingMoviesFrance(completion: @escaping (Result<MovieResponse1, IDError>)->())
    //trending movies in UK
    func trendingMoviesUK(completion: @escaping (Result<MovieResponse1, IDError>)->())
    //trending movies in India
    func trendingMoviesIndia(completion: @escaping (Result<MovieResponse1, IDError>)->())
    //trending movies in Egypt
    func trendingMoviesEgypt(completion: @escaping (Result<MovieResponse1, IDError>)->())
   
}

//home page movie sections
enum MovieListEndpoint: String {
    case nowPlaying = "now_playing"
    case upcoming = "upcoming"
    case topRated = "top_rated"
    case popular = "popular"
    //how they will look on the home screen
    var description: String {
        switch self {
        case .nowPlaying: return "Now Playing"
        case .upcoming: return "Upcoming"
        case .topRated: return "Top Rated"
        case .popular: return "Popular"
        }
    }
}


//five error cases
enum MovieError: Error, CustomNSError {
    //generic error
    case apiError
    //error when constructing the endpoint URL
    case invalidEndpoint
    //HTTP error when the response status code is not between 200 & 300
    case invalidResponse
    case noData
    //JSON decoding error
    case serializationError
    
    //returning the text for each error
    var ErrorDescription: String{
        switch self{
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        
        }
    
    }
    //to print the error text properly when the error is casted as NS error we need to
    // conform to custom NS error protocol and declare the error user info dictionary property
    var errorUserInfo: [String : Any]{
        //NSlocalizeddescriptionkey with the localizedDescription value
        [NSLocalizedDescriptionKey: ErrorDescription]
    }
}

enum IDError: Error, CustomNSError {
    //generic error
    case apiError
    //error when constructing the endpoint URL
    case invalidEndpoint
    //HTTP error when the response status code is not between 200 & 300
    case invalidResponse
    case noData
    //JSON decoding error
    case serializationError
    
    //returning the text for each error
    var ErrorDescription: String{
        switch self{
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        
        }
    
    }
    //to print the error text properly when the error is casted as NS error we need to
    // conform to custom NS error protocol and declare the error user info dictionary property
    var errorUserInfo: [String : Any]{
        //NSlocalizeddescriptionkey with the localizedDescription value
        [NSLocalizedDescriptionKey: ErrorDescription]
    }
}
