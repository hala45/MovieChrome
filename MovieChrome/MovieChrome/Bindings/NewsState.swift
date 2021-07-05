//
//  NewsState.swift
//  MovieChrome
//
//  Created by Hala Basyouni on 12/22/20.
//

import SwiftUI

class NewsListState: ObservableObject {
    
    @Published var news: [News]?
    @Published var isLoading: Bool = false
    @Published var error: NSError?

    private let NewsService: NewsService
    
    init(NewsService: NewsService = NewsStore.shared) {
        self.NewsService = NewsService
    }
    
    func loadNews(with endpoint: NewsListEndpoint) {
        self.news = nil
        self.isLoading = true
        self.NewsService.fetchNews(from: endpoint) { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.news = response.results
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
}

struct NewsListState_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

