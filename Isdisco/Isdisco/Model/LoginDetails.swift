//
//  LoginDetails.swift
//  Isdisco
//
//  Created by Magnus Stjernborg Koch on 06/05/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import Foundation
import SwiftyJSON

class LoginDetails {
    let username: String
    let password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }

    static func objectToJson (object: LoginDetails) -> [String: Any] {
        return ["username": object.username,
                "password": object.password]
    }
}
