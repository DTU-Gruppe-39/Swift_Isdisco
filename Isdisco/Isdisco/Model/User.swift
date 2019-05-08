//
//  User.swift
//  Isdisco
//
//  Created by Magnus Stjernborg Koch on 06/05/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import Foundation
import SwiftyJSON

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
    
    func toJSON() -> JSON {
        return [
            "id": id as Int,
            "fullname": fullname as String,
            "vip": vip as Bool,
            "loginDetails": loginDetails as LoginDetails,
            "appToken": appToken as String,
            "facebookToken": facebookToken as String
        ]
    }
}
