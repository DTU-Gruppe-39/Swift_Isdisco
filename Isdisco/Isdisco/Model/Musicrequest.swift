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
    let downvotes: [Int]
    
    init(id: Int, track: Track,userId: Int, timestamp: String, downvotes: [Int],upvotes: [Int]) {
        self.id = id
        self.track = track
        self.userId = userId
        self.timestamp = timestamp
        self.downvotes = downvotes
        self.upvotes = upvotes
    }
    
    //In use when sending musicrequest to server
    init(track: Track, userId: Int) {
        self.id = 0;
        self.track = track;
        self.userId = userId;
        self.timestamp = ""
        self.downvotes = [Int]()
        self.upvotes = [Int]()
    }
    
    static func jsonToObject (json: JSON) -> Musicrequest {
        var upvotesArray = [Int]()
        var downvotesArray = [Int]()
        for upvote in json["upvotes"].arrayValue {
            upvotesArray.append(upvote.intValue)
        }
        for downvote in json["downvotes"].arrayValue {
            downvotesArray.append(downvote.intValue)
        }
        
        return Musicrequest(id: json["id"].intValue,track: Track.jsonToObject(json: json["track"]),userId: json["userId"].intValue,timestamp: json["timestamp"].stringValue,downvotes: downvotesArray,upvotes: upvotesArray)
    }

    static func objectToJson (object: Musicrequest) -> [String: Any] {
        return ["track":
                    Track.objectToJson(object: object.track),
                "userid":Singleton.shared.currentUserId]
    }
}
