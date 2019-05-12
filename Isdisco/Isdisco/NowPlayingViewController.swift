//
//  NowPlayingViewController.swift
//  Isdisco
//
//  Created by Thomas Mattsson on 28/03/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import UIKit
import Alamofire
import MarqueeLabel
import SwiftyJSON


extension UIViewController {
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
}

//Struct for parsing JSON
struct CurrentlyPlaying: Decodable {
    let track : Track
    let duration : Int
    let progress : Int
}

class NowPlayingViewController: UIViewController {
    
    @IBOutlet weak var albumArt: UIImageView!
    @IBOutlet weak var songTitle: MarqueeLabel!
    @IBOutlet weak var artistName: MarqueeLabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var openInSpotifyButton: UIButton!
    
    //Open the currently playing song in Spotify
    @IBAction func openInSpotify(_ sender: Any) {
        UIApplication.shared.open(URL(string: spotifyLink)!, options: [:], completionHandler: nil)
    }
    
    let fetchImageAPI = FetchImageAPI()
    let apiUrl = "https://isdisco.azurewebsites.net/api/spotify-track/currently-playing"
    var spotifyLink: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 10.0, *) {
            let refreshControl = UIRefreshControl()
            let title = "Træk for at genindlæse"
            refreshControl.attributedTitle = NSAttributedString(string: title)
            refreshControl.addTarget(self,
                                     action: #selector(refreshOptions(sender:)),
                                     for: .valueChanged)
            scrollView.refreshControl = refreshControl
        }
        
        // set observer for UIApplication.willEnterForegroundNotification
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    // my selector that was defined above
    @objc func willEnterForeground() {
        pullSongAsync() { error in
            if error != nil {
                print("Oops! Something went wrong...")
            } else {
                print("It has finished")
            }
        }
    }
    
    //ObjC function to trigger refresh adapted from StackOberflow
    @objc func refreshOptions(sender: UIRefreshControl) {
        pullSongAsync() { error in
            if error != nil {
                self.delay(0.1, closure: {
                    sender.endRefreshing()
                    print("Oops! Something went wrong...")
                })
            } else {
                self.delay(0.1, closure: {
                    print("It has finished")
                    sender.endRefreshing()
                })
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pullSongAsync() { error in
            if error != nil {
                print("Oops! Something went wrong...")
            } else {
                print("It has finished")
            }
        }
    }
    
    func pullSongAsync(completion: @escaping (Error?) -> Void) {
        
        self.openInSpotifyButton.isHidden = true
        
        //Performing an Alamofire request to get the data from the URL
        Alamofire.request(self.apiUrl).responseJSON { response in
            //now here we have the response data that we need to parse
            let json = response.data
            
            do{
                //created the json decoder
                let decoder = JSONDecoder()
                
                //Parsing the currently playing object from "json".
                let currentlyPlaying = try decoder.decode(CurrentlyPlaying.self, from: json!)
                
                //Test print
                print(currentlyPlaying.track.songName)
                
                let songTitle = currentlyPlaying.track.songName
                let artistName = currentlyPlaying.track.artistName
                let imageUrl = currentlyPlaying.track.image_large_url
                self.spotifyLink = currentlyPlaying.track.webplayerLink
                
                //Setting the picture
                self.fetchImageAPI.fetchImage(urlToImageToFetch: imageUrl, completionHandler: {
                    image, _ in self.albumArt?.image = image
                })
                
                //Setting the labels
                self.songTitle.text = songTitle
                self.artistName.text = artistName
                self.openInSpotifyButton.isHidden = false
                
                //Nil indicates "no error"
                completion(nil) // Or completion(SomeError.veryBadError)
                
            } catch let err{
                print(err)
                completion(err)
                
                //Default values
                self.songTitle.text = "Ingen sange spiller nu"
                self.artistName.text = ""
                self.albumArt.image = UIImage(named: "LOGO_ISDISCO")
                self.openInSpotifyButton.isHidden = true
            }
        }
    }
}
