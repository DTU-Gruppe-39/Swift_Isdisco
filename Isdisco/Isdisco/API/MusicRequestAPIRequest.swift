//
//  MusicRequestAPIRequest.swift
//  Isdisco
//
//  Created by Thomas Mattsson on 12/05/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import Foundation
import Alamofire

struct MusicRequest: Decodable{
    let id: Int
    let track: Track
    let userId: Int
    let timestamp: String
    let upvotes: [Int]?
    let downvotes: [Int]?
    let upvoteUsers: [User]?
    let downvoteUsers: [User]?
    
    struct User: Decodable {
        let id: Int
        let fullname: String
        let vip: Bool
        let loginDetails: LoginDetails
        let appToken: String
        let facebookToken: String?
    }
    
    struct LoginDetails: Decodable {
        let username: String
        let password: String
    }
}


class MusicReqeustAPIRequest {
    let apiUrl = "https://isdisco.azurewebsites.net/api/musicrequest"
    
    var musicRequests = [MusicRequest]()

    func fetchMusicRequests(completion: @escaping ([MusicRequest]) -> Void) {
        //Performing an Alamofire request to get the data from the URL
        Alamofire.request(self.apiUrl).responseJSON { response in
            //now here we have the response data that we need to parse
            let json = response.data
            
            do{
                //created the json decoder
                let decoder = JSONDecoder()
                
                //Parsing the currently playing object from "json".
                self.musicRequests = try decoder.decode([MusicRequest].self, from: json!)
                //print(self.musicRequests[3].track.songName)
                completion(self.musicRequests)
            } catch let err {
                print(err)
            }
        }
    }
}
