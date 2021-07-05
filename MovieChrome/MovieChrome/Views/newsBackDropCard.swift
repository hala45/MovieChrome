//
//  newsBackDropCard.swift
//  MovieChrome
//
//  Created by Hala Basyouni on 12/22/20.
//

import SwiftUI



struct newsBackDropCard : View {
    let news: News
    @ObservedObject var imageLoader = ImageLoader()
    var body: some View {
        //to display image and text vertically
        VStack(alignment: .leading) {
        //ZStack is the container for the image
           
        ZStack{
            //to display the image in a rectangular shape
            Rectangle()
                .fill(Color.gray.opacity(0.3))
            if self.imageLoader.image != nil{
                //passing the image url to the image initializer
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                   
            }
        }
        //backdrop image that uses 16 by 9 aspect ratio
        //aspect ratio modifier
        .aspectRatio(16/9, contentMode: .fit)
        //corner radius to make the corner of the images rounded
        .cornerRadius(8)
        .shadow(radius:4)
        //print the movie title under the movie image
            Text(verbatim: news.title)
        }
        .lineLimit(1)
        //to download the image from the network we invoke the image loaders
        //to fetch the image
        
        .onAppear {
            self.imageLoader.loadImage(with:
                                        self.news.image)
        }
    }
}

