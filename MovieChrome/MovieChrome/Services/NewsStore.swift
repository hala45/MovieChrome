//
//  NewsStore.swift
//  MovieChrome
//
//  Created by Hala Basyouni on 12/22/20.
//

import Foundation


//define the MovieStore class which is linked to the MovieServices protocol
class NewsStore : NewsService {
    
    func fetchNews(from endpoint: NewsListEndpoint,completion: @escaping (Result<NewsResponse, NewsError>) -> ()) {
        
        guard let url = URL(string: "\(apiURL)/search\(endpoint.rawValue)") else{
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    
    

   
    //static shared constant
    static let shared = NewsStore()
    
    //set the initializer as private to make sure the instance can only be initialized once in the runtime
    private init() {}
    
    //the API key constant
    private let apiKey = "5668974bb878991679c175dc58469a7c"
    //the api general URL
    private let apiURL = "https://gnews.io/api/v4"
    //to make a new URL request
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
   


    // helper method to load and decode the URL into data using generic method
    //accepts additional dictionary as a param to decode this will be converted to URl params some encoding format
        
        private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, NewsError>) -> ()) {
                    guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                        completion(.failure(.invalidEndpoint))
                        return
                    }
        
        //array of URL query items //URL query item is a struct representing URL param key and value
        //api key URL and api key constant(from site)
        var queryItems = [URLQueryItem(name:"api_key",value: apiKey)]
        
        //flag to unwrap the params dictionary //if the value is not null we append the param by transforming into an array of URL query item by assigning the key and value
        if let params = params{
            queryItems.append(contentsOf: params.map{URLQueryItem(name: $0.key, value: $0.value)})
        }
            urlComponents.queryItems = queryItems
            //accessing the URL components optional url property all the query items will be escaped
            //using the safe person encoding format
            guard let finalURL = urlComponents.url else{
                completion(.failure(.invalidEndpoint))
                return
            }
            //urlSession data task method to pass the apiError if the error is not equal to null
            urlSession.dataTask(with: finalURL) { [weak self] (data, response, error) in
                        guard let self = self else { return }
                        
                        if error != nil {
                            self.executeCompletionHandlerInMainThread(with: .failure(.apiError), completion: completion)
                            return
                        }
            
                        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                               self.executeCompletionHandlerInMainThread(with: .failure(.invalidResponse), completion: completion)
                               return
                           }
                           
                           guard let data = data else {
                               self.executeCompletionHandlerInMainThread(with: .failure(.noData), completion: completion)
                               return
                           }
                           
                           do {
                               let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                               self.executeCompletionHandlerInMainThread(with: .success(decodedResponse), completion: completion)
                           } catch {
                               self.executeCompletionHandlerInMainThread(with: .failure(.serializationError), completion: completion)
                           }
                       }.resume()
                   }
    
        
    //to call the result completion into the main thread declaring a helper method(accepts the completion //closure and the result using generic placeholder to constraint the data only for the decodable type
        private func executeCompletionHandlerInMainThread<D: Decodable>(with result: Result<D, NewsError>, completion: @escaping (Result<D, NewsError>) -> ()) {
                  DispatchQueue.main.async {
                      completion(result)
                  }
              }




}

