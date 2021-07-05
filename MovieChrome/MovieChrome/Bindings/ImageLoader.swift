//
//  imageLoader.swift
//  MovieChrome
//
//  Created by Hala Basyouni on 10/30/20.
//

import SwiftUI
//to store UI image as property inside the class
import UIKit


private let _imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoader : ObservableObject {
    //published property wrapper to load the properties of an image
    @Published var image : UIImage?
    @Published var isLoading = false
    
    var imageCache = _imageCache
    
    //load image that accepts the image url// we get the absolute the string of the url and assign it to a variable this acts as the key to retrive the image from the cache if the image exists we assign it to the image property and download the image
    func loadImage(with url: URL){
        let urlString = url.absoluteString
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject)as?UIImage{
            self.image = imageFromCache
            return
        }
        DispatchQueue.global(qos: .background).async { [weak self ] in
            guard self != nil else{ return }
            do{
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data)else {
                        return
               }
                self?.imageCache.setObject(image, forKey: urlString as AnyObject)
                DispatchQueue.main.async {[weak self] in
                    self?.image = image
                }
                
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
}

struct ImageLoader_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
