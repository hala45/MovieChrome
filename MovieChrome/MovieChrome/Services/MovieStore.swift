//
//  MovieStore.swift
//  MovieChrome
//
//  Created by Hala Basyouni on 9/28/20.
//

import Foundation


//define the MovieStore class which is linked to the MovieServices protocol
class MovieStore : MovieService{

    func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(apiURL)/movie/\(endpoint.rawValue)")else{
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        guard let url = URL(string: "\(apiURL)/movie/\(id)")else{
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, params: [
                                
         "append_to_response" : "videos_credits"
        ],completion: completion)
    }

    
    
    func searchMovie(query: String, completion:@escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(apiURL)/search/movie")else{
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, params: [
            "language" : "en-US",
            "include_adult": "false",
            "region": "US",
            "query": query
        ],completion: completion)
    }
    
    func trendingMoviesWeek(completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(apiURL)/trending/movie/week")else{
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func trendingMoviesDay(completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(apiURL)/trending/movie/day")else{
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
 
    func trendingMoviesGermany(completion: @escaping (Result<MovieResponse1, IDError>) -> ()) {
        guard let url = URL(string: "\(apiURL)/discover/movie")else{
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode1(url: url, params: [
            "language" : "de-DE",
            "region" : "DE",
            "release_date.gte" : "2021-01-01",
            "release_date.lte" : "2021-03-17",
            "with_release_type" : "2|3"
          
           
        ],completion: completion)
    }
    
    func trendingMoviesItaly(completion: @escaping (Result<MovieResponse1, IDError>) -> ()) {
        guard let url = URL(string: "\(apiURL)/discover/movie")else{
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode2(url: url, params: [
            "language" : "it-IT",
            "region" : "IT",
            "release_date.gte" : "2021-01-01",
            "release_date.lte" : "2021-03-17",
            "with_release_type" : "2|3"
          
           
        ],completion: completion)
    }
    
    func trendingMoviesFrance(completion: @escaping (Result<MovieResponse1, IDError>) -> ()) {
        guard let url = URL(string: "\(apiURL)/discover/movie")else{
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode3(url: url, params: [
            "language" : "fr-FR",
            "region" : "FR",
            "release_date.gte" : "2021-01-01",
            "release_date.lte" : "2021-03-17",
            "with_release_type" : "2|3"
          
           
        ],completion: completion)
    }
    
    func trendingMoviesIndia(completion: @escaping (Result<MovieResponse1, IDError>) -> ()) {
        guard let url = URL(string: "\(apiURL)/discover/movie")else{
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode6(url: url, params: [
            "language" : "in-IN",
            "region" : "IN",
            "release_date.gte" : "2021-01-01",
            "release_date.lte" : "2021-03-17",
            "with_release_type" : "2|3"
          
           
        ],completion: completion)
    }
    func trendingMoviesUK(completion: @escaping (Result<MovieResponse1, IDError>) -> ()) {
        guard let url = URL(string: "\(apiURL)/discover/movie")else{
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode7(url: url, params: [
            "language" : "gb-GB",
            "region" : "GB",
            "release_date.gte" : "2021-01-01",
            "release_date.lte" : "2021-03-17",
            "with_release_type" : "2|3"
          
           
        ],completion: completion)
    }
    func trendingMoviesEgypt(completion: @escaping (Result<MovieResponse1, IDError>) -> ()) {
        guard let url = URL(string: "\(apiURL)/discover/movie")else{
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode8(url: url, params: [
            "language" : "eg-EG",
            "region" : "EG",
            "release_date.gte" : "2021-01-01",
            "release_date.lte" : "2021-03-17",
            "with_release_type" : "2|3"
          
           
        ],completion: completion)
    }
    
    
    //static shared constant
    static let shared = MovieStore()
    
    //set the initializer as private to make sure the instance can only be initialized once in the runtime
    private init() {}
    
    //the API key constant
    private let apiKey = "enter your api key here"
    //the api general URL
    private let apiURL = "https://api.themoviedb.org/3"
    //to make a new URL request
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
   


    // helper method to load and decode the URL into data using generic method
    //accepts additional dictionary as a param to decode this will be converted to URl params some encoding format
        
        
    private func loadURLAndDecode1<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, IDError>) -> ()) {
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
    private func executeCompletionHandlerInMainThread<D: Decodable>(with result: Result<D, IDError>, completion: @escaping (Result<D, IDError>) -> ()) {
              DispatchQueue.main.async {
                  completion(result)
              }
          }
    
    private func loadURLAndDecode2<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, IDError>) -> ()) {
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
    private func executeCompletionHandlerInMainThread2<D: Decodable>(with result: Result<D, IDError>, completion: @escaping (Result<D, IDError>) -> ()) {
              DispatchQueue.main.async {
                  completion(result)
              }
          }
    
    // helper method to load and decode the URL into data using generic method
    //accepts additional dictionary as a param to decode this will be converted to URl params some encoding format
        
        
    private func loadURLAndDecode3<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, IDError>) -> ()) {
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
    private func executeCompletionHandlerInMainThread3<D: Decodable>(with result: Result<D, IDError>, completion: @escaping (Result<D, IDError>) -> ()) {
              DispatchQueue.main.async {
                  completion(result)
              }
          }
    
    
    // helper method to load and decode the URL into data using generic method
    //accepts additional dictionary as a param to decode this will be converted to URl params some encoding format
        
        
    private func loadURLAndDecode4<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, IDError>) -> ()) {
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
    private func executeCompletionHandlerInMainThread4<D: Decodable>(with result: Result<D, IDError>, completion: @escaping (Result<D, IDError>) -> ()) {
              DispatchQueue.main.async {
                  completion(result)
              }
          }
    
    
    // helper method to load and decode the URL into data using generic method
    //accepts additional dictionary as a param to decode this will be converted to URl params some encoding format
        
        
    private func loadURLAndDecode5<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, IDError>) -> ()) {
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
    private func executeCompletionHandlerInMainThread5<D: Decodable>(with result: Result<D, IDError>, completion: @escaping (Result<D, IDError>) -> ()) {
              DispatchQueue.main.async {
                  completion(result)
              }
          }
    
    // helper method to load and decode the URL into data using generic method
    //accepts additional dictionary as a param to decode this will be converted to URl params some encoding format
        
        
    private func loadURLAndDecode6<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, IDError>) -> ()) {
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
    private func executeCompletionHandlerInMainThread6<D: Decodable>(with result: Result<D, IDError>, completion: @escaping (Result<D, IDError>) -> ()) {
              DispatchQueue.main.async {
                  completion(result)
              }
          }
    
    // helper method to load and decode the URL into data using generic method
    //accepts additional dictionary as a param to decode this will be converted to URl params some encoding format
        
        
    private func loadURLAndDecode7<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, IDError>) -> ()) {
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
    private func executeCompletionHandlerInMainThread7<D: Decodable>(with result: Result<D, IDError>, completion: @escaping (Result<D, IDError>) -> ()) {
              DispatchQueue.main.async {
                  completion(result)
              }
          }
    
    // helper method to load and decode the URL into data using generic method
    //accepts additional dictionary as a param to decode this will be converted to URl params some encoding format
        
        
    private func loadURLAndDecode8<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, IDError>) -> ()) {
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
    private func executeCompletionHandlerInMainThread8<D: Decodable>(with result: Result<D, IDError>, completion: @escaping (Result<D, IDError>) -> ()) {
              DispatchQueue.main.async {
                  completion(result)
              }
          }
    
        private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, MovieError>) -> ()) {
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
        private func executeCompletionHandlerInMainThread<D: Decodable>(with result: Result<D, MovieError>, completion: @escaping (Result<D, MovieError>) -> ()) {
                  DispatchQueue.main.async {
                      completion(result)
                  }
              }




}
