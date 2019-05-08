//
//  NowPlayingViewController.swift
//  Isdisco
//
//  Created by Thomas Mattsson on 28/03/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NowPlayingViewController: UIViewController {

    @IBOutlet weak var albumArt: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "https://isdisco.azurewebsites.net/api/spotify-track/currently-playing"
        Alamofire.request(url, method: .get, parameters:nil, encoding: JSONEncoding.default).responseJSON { response in
            print(response)
            
            if let json = response.result.value as? [String:Any] {
                print(json["songName"])
            }
        }
        
        self.songTitle.text = Singleton.shared.tracks[0].title
        
        
        // Do any additional setup after loading the view.
    }
    

}
