//
//  NewsService.swift
//  MovieChrome
//
//  Created by Hala Basyouni on 12/22/20.
//

import Foundation


protocol NewsService {

    func fetchNews(from endpoint: NewsListEndpoint,completion: @escaping (Result<NewsResponse, NewsError>)->())
   
}

//home page movie sections
enum NewsListEndpoint: String {
    
    case Movie = "movie"
    var description: String {
        switch self {
        case .Movie: return "Headlines"
       
        }
    }
  
    
 
}

//five error cases
enum NewsError: Error, CustomNSError {
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

