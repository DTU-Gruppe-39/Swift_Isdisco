//
//  Feedback.swift
//  Isdisco
//
//  Created by Thomas Mattsson on 06/05/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//
import Foundation

class Feedback {
    let user: User
    let tag : String
    let message : String
    
    init(user: User, tag: String, message: String) {
        self.user = user
        self.tag = tag
        self.message = message
    }
    
    static func objectToJson (object: Feedback) -> [String: Any] {
        return ["user":User.objectToJson(object: object.user),
                "tag":object.tag,
                "message":object.message]
    }
}
