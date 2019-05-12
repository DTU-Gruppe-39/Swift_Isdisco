//
//  TrackImage.swift
//  Isdisco
//
//  Created by Magnus Stjernborg Koch on 12/05/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import Foundation
import SwiftyJSON

class TrackImage {
    let id: String
    let songName: String
    let artistName: String
    let image_small_url: String
    let image_medium_url: String
    let image_large_url: String
    let webplayerLink: String
    
    let fetchedImage: UIImage? = nil
    
    init(id: String, songName: String, artistName: String, image_small_url: String, image_medium_url: String, image_large_url: String, webplayerLink: String) {
        self.id = id
        self.songName = songName
        self.artistName = artistName
        self.image_small_url = image_small_url
        self.image_medium_url = image_medium_url
        self.image_large_url = image_large_url
        self.webplayerLink = webplayerLink
    }
    
    static func jsonToObject (json: JSON) -> TrackImage {
        return TrackImage(id: json["id"].stringValue, songName: json["songName"].stringValue, artistName: json["artistName"].stringValue, image_small_url: json["image_small_url"].stringValue, image_medium_url: json["image_medium_url"].stringValue, image_large_url: json["image_large_url"].stringValue, webplayerLink: json["webplayerLink"].stringValue)
    }
    
    static func objectToJson (object: TrackImage) -> [String: Any] {
        return ["id":object.id,
                "songName":object.songName,
                "artistName":object.artistName,
                "image_small_url":object.image_small_url,
                "image_medium_url":object.image_medium_url,
                "image_large_url":object.image_large_url,
                "webplayerLink":object.webplayerLink]
    }
}
