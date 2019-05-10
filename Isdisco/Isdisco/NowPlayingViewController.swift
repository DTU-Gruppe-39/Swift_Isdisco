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

struct CurrentlyPlaying: Decodable {
    let track : Track
    let duration : Int
    let progress : Int
}


class NowPlayingViewController: UIViewController {
    
    @IBOutlet weak var albumArt: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    let apiRequest = SearchAPIRequest()
    let apiUrl = "https://isdisco.azurewebsites.net/api/spotify-track/currently-playing"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Performing an Alamofire request to get the data from the URL
        Alamofire.request(self.apiUrl).responseJSON { response in
            //now here we have the response data that we need to parse
            let json = response.data
            
            do{
                //created the json decoder
                let decoder = JSONDecoder()
                
                //Parsing the currently playing object from "json".
                let currentlyPlaying = try decoder.decode(CurrentlyPlaying.self, from: json!)
                
                print(currentlyPlaying.track.songName)
                
                let songTitle = currentlyPlaying.track.songName
                let artistName = currentlyPlaying.track.artistName
                let imageUrl = currentlyPlaying.track.image_large_url
                
                self.apiRequest.fetchImage(urlToImageToFetch: imageUrl, completionHandler: {
                    image, _ in self.albumArt?.image = image
                })
                
                self.songTitle.text = songTitle
                self.artistName.text = artistName
                
            } catch let err{
                print(err)
                
                self.songTitle.text = "Ingen sange spiller nu"
                self.artistName.text = ""
                self.albumArt.image = UIImage(named: "LOGO_ISDISCO")
            }
        }
    }
}
