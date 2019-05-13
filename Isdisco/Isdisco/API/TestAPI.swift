//
//  TestAPI.swift
//  Isdisco
//
//  Created by Rasmus Gregersen on 13/05/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import Foundation
import Alamofire

class TestAPI {
    func resetList() {
        Alamofire.request("https://isdisco.azurewebsites.net/api/settings/reset", method: .delete)
    }
}
