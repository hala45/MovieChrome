//
//  Movie .swift
//  MovieChrome
//
//  Created by Hala Basyouni on 9/28/20.
//

import Foundation



struct MovieResponse: Decodable {
    
    let results: [Movie]
}

struct MovieResponse1: Decodable {
    
    let results: [Movie]
}



struct Movie: Decodable, Identifiable, Hashable {
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
        
       
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
       
    }

    
    let id: Int
    let title: String
    let backdropPath: String?
    let voteAverage: Double
    let releaseDate: String?
    
    
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    
    var yearText: String {
        guard let releaseDate = self.releaseDate, let date = Utils.dateFormatter.date(from: releaseDate) else {
            
            return "n/a"
        }
        return Movie.yearFormatter.string(from: date)
    }
    
    //backdropurl to get the image of the movie from the api using the general URL
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    //details url to get the details page of a movie
    var detailsURL : URL {
        return URL(string: "https://www.themoviedb.org/movie/\(id)")!
    }

    var ratingText: String {
        let rating = Int(voteAverage)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        return ratingText
    }
    
    var scoreText: String {
        guard ratingText.count > 0 else {
            return "n/a"
        }
        return "\(ratingText.count)/10"
    }
    

}










