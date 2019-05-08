//
//  User.swift
//  Isdisco
//
//  Created by Magnus Stjernborg Koch on 06/05/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import Foundation

class User {
    let id: Int
    let fullname: String
    let vip: Bool
    let loginDetails: LoginDetails
    let appToken: String
    let facebookToken: String
    
    init(id: Int, fullname: String, vip: Bool, loginDetails: LoginDetails, appToken: String, facebookToken: String) {
        self.id = id
        self.fullname = fullname
        self.vip = vip
        self.loginDetails = loginDetails
        self.appToken = appToken
        self.facebookToken = facebookToken
    }
    
    
    static func objectToJson (object: User) -> [String: Any] {
        return ["id":object.id,
                "fullname":object.fullname,
                "vip":object.vip,
                "loginDetails:":
                    LoginDetails.objectToJson(object: object.loginDetails),
                "appToken":object.appToken,
                "facebookToken":object.facebookToken
                ]
    }
}
