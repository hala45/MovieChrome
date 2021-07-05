//
//  News.swift
//  MovieChrome
//
//  Created by Hala Basyouni on 12/22/20.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI


struct News: Identifiable {
    
    var id : String
    var title : String
    var desc : String
    var url : String
    var image : String
    
   
    
}


class getData : ObservableObject{
    
    @Published var datas = [News]()
    
    init(){
        
        
        let source = "https://newsapi.org/v2/everything?q=movies&apiKey=a90ab632afc5408ea7bec3a6bed79866"
        let url = URL(string: source)!
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { (data, _, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            let json = try! JSON(data: data!)
            
            for i in json["articles"]{
                
                let title = i.1["title"].stringValue
                let description = i.1["description"].stringValue
                let url = i.1["url"].stringValue
                let image = i.1["urlToImage"].stringValue
                let id = i.1["publishedAt"].stringValue
                
              
                
                DispatchQueue.main.async {
                    self.datas.append(News(id: id, title: title, desc: description, url: url, image: image))
                }
           
            }
        }.resume()
    
    }
}



