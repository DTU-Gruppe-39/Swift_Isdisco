//
//  SearchAPIRequest.swift
//  Isdisco
//
//  Created by Magnus Stjernborg Koch on 29/04/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

enum  NetworkError: Error {
    case success
    case failure
}

class SearchAPIRequest {
    var searchResults = [JSON]()
    
    func search(textToSearch: String, completionHandler: @escaping ([JSON]?, NetworkError) -> ()) {
        let urlToSearch = "https://isdisco-web-api.azurewebsites.net/api/spotify-track/search?songname=\(textToSearch)"
        
        Alamofire.request(urlToSearch).responseJSON { response in
            guard let data = response.data else {
                completionHandler(nil, .failure)
                print("error - 1")
                return
            }
            
            let json = try? JSON(data: data)
            let results = json?["tracks"]["items"].arrayValue
            guard let empty = results?.isEmpty, !empty else {
                completionHandler(nil, .failure)
                print("error - 2")
                return
            }
            print(results?.count)
            print(results?[0])
            print(results?[0]["name"].stringValue)
            completionHandler(results, .success)
        }
    }
    
    func fetchImage(urlToImageToFetch: String, completionHandler: @escaping (UIImage?, NetworkError) -> ()) {
        Alamofire.request(urlToImageToFetch).responseData { responseData in
            
            guard let imageData = responseData.data else {
                completionHandler(nil, .failure)
                return
            }
            
            guard let image = UIImage(data: imageData) else {
                completionHandler(nil, .failure)
                return
            }
            
            completionHandler(image, .success)
        }
    }
}
