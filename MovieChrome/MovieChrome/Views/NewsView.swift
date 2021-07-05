//
//  NewsView.swift
//  MovieChrome
//
//  Created by Hala Basyouni on 12/23/20.
//

import SwiftUI
import SDWebImageSwiftUI
import WebKit

struct NewsView: View {
    
    @ObservedObject var list = getData()
  
    var body: some View {
        NavigationView{
            List(list.datas){ i in
                NavigationLink(destination:
                    webView(url: i.url)
                        .navigationBarTitle("Headlines", displayMode: .inline)){
                    HStack(spacing:15){
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text(i.title).fontWeight(.heavy)
                                Text(i.desc).lineLimit(2)
                            }
                            WebImage(url: URL(string: i.image)).resizable().frame(width:116,height:128)
                                .cornerRadius(20)
                                .shadow(radius:4)
                        
                        }.padding(.vertical, 15)
                        }
                    }.navigationBarTitle("Headlines")
                
                
            }
     
        }
    
}

struct News_Previews: PreviewProvider {
    static var previews: some View {
       NewsView()
    }
}


struct webView: UIViewRepresentable {
    
  
    let url : String

    func makeUIView(context: UIViewRepresentableContext<webView>) -> WKWebView {
        let webView = WKWebView()
       
        webView.load(URLRequest(url: URL(string:url)!))
        webView.allowsBackForwardNavigationGestures = false
        return webView
    }
        
            
        

    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<webView>) {

    }
}


