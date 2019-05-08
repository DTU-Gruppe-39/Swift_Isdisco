//
//  SongRequest.swift
//  Isdisco
//
//  Created by Magnus Stjernborg Koch on 06/05/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import Foundation
import SwiftyJSON

class Musicrequest {
    let id: Int
    let track: Track
    let userId: Int
    let timestamp: String  //Should probably be milliseconds and then calculated to min/hours as an Int insted of a double
    let upvotes: [Int]
    let downvotes: Int
    
    init(id: Int, track: Track,userId: Int, timestamp: String, downvotes: Int,upvotes: [Int]) {
        self.id = id;
        self.track = track;
        self.userId = userId;
        self.timestamp = timestamp
        self.downvotes = downvotes;
        self.upvotes = upvotes
    }
    
    /*static func jsonToObject (json: JSON) -> Musicrequest {
        var upvotesArray: [Int]
        for upvote in json["upvotes"].arrayValue {
            upvotesArray.append(upvote.intValue)
        }
        
        return Musicrequest(id: json["id"].intValue,track: Track.jsonToObject(json: json["track"]),userId: json["userId"].intValue,timestamp: json["timestamp"].stringValue,downvotes: json["downvotes"].intValue,upvotes: upvotesArray)
    }

    static func objectToJson (object: Musicrequest) -> [String: Any] {
        return ["track":
                    [
                        "id":object.track.id,
                        "songName":object.track.songName,
                        "artistName":object.track.artistName,
                        "image_small_url":object.track.image_small_url,
                        "image_medium_url":object.track.image_medium_url,
                        "image_large_url":object.track.image_large_url,
                        "webplayerLink":object.track.webplayerLink
                    ],
                "userid":1]
    }*/
}
