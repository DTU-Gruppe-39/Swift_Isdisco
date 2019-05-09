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

struct CurrentlyPlaying :Decodable {
    let track : Track
    let duration : Int
    let progress : Int
}

class NowPlayingViewController: UIViewController {

    @IBOutlet weak var albumArt: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ApiUrl = "https://isdisco.azurewebsites.net/api/spotify-track/currently-playing"
        
        guard let url = URL(string: ApiUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                let currentlyPlaying = try
                    JSONDecoder().decode(CurrentlyPlaying.self, from: data)
                print(currentlyPlaying.track.songName)
            } catch let jsonErr {
                print("Error", jsonErr)
            }
        }
    }
        
        //self.songTitle.text = Singleton.shared.tracks[0].title
        
        
        // Do any additional setup after loading the view.
}
