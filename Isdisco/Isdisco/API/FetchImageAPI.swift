//
//  FetchImageAPI.swift
//  Isdisco
//
//  Created by Magnus Stjernborg Koch on 08/05/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class FetchImageAPI {
    func fetchImage(urlToImageToFetch: String, completionHandler: @escaping (UIImage?, NetworkError) -> ()) {
        Alamofire.request(urlToImageToFetch).responseData { responseData in
            
            guard let imageData = responseData.data else {
                completionHandler(nil, .failure)
                print("error - 3")
                return
            }
            
            guard let image = UIImage(data: imageData) else {
                completionHandler(nil, .failure)
                print("error - 4")
                return
            }
            
            completionHandler(image, .success)
        }
    }
}

