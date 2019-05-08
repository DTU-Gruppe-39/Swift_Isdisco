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

class SearchAPIRequest {
    func search(textToSearch: String, completionHandler: @escaping ([JSON]?, NetworkError) -> ()) {
        let urlToSearch = "https://isdisco.azurewebsites.net/api/spotify-track/search"
        let parameters = [
            "songname": textToSearch
        ]
        
        Alamofire.request(urlToSearch, method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            guard let data = response.data else {
                completionHandler(nil, .failure)
                print("error - request error")
                return
            }
            
            let json = try? JSON(data: data)
            let results = json?["tracks"].arrayValue
            guard let empty = results?.isEmpty, !empty else {
                completionHandler(nil, .failure)
                print("error - no results")
                return
            }
            completionHandler(results, .success)
        }
    }
}
