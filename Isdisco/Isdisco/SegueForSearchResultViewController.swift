//
//  SegueForSearchResultViewController.swift
//  Isdisco
//
//  Created by Magnus Stjernborg Koch on 04/05/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SegueForSearchResultViewController: UIViewController {
    
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var song_name: UILabel!
    @IBOutlet weak var artist: UILabel!
    
    var albumImage_url:String = ""
    var song_name_text:String = ""
    var artist_text:String = ""
    var spotify_url_text:String = ""
    
    let apiRequest = SearchAPIRequest()
    
    override func viewWillAppear(_ animated: Bool) {
        song_name.text = song_name_text
        artist.text = artist_text
        
        apiRequest.fetchImage(urlToImageToFetch: albumImage_url, completionHandler: {
            image, _ in self.albumImage?.image = image
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func requestTrack(_ unwindSegue: UIStoryboardSegue) {
        let musicrequest: [String: Any] = ["track":
                [
                    ["id":"i"],
                    ["songName","i"],
                    ["artistName":"i"],
                    ["image_small_url":"i"],
                    ["image_medium_url","i"],
                    ["image_large_url","i"],
                    ["webplayerLink":"i"]
                    ],
              "userid":1]
        
        Alamofire.request("https://isdisco.azurewebsites.net/api/musicrequest", method: .post, parameters: musicrequest, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
                case .success:
                    print("Ønske er sendt: \(response.request) , \(response.response) , \(response.result)")
                    self.dismiss(animated: true, completion: nil)
                case .failure(let _):
                    print("Fejl i sending af ønske , \(response.request) , \(response.response) , \(response.result)")
                    self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func OpenInSpotify(_ sender: Any) {
        print("Spotify: \(spotify_url_text)")
        let url = URL(string: spotify_url_text)
        if #available(iOS 10.0, *) {
            UIApplication.shared.open((url)!)
        } else {
            UIApplication.shared.openURL((url)!)
        }
    }
    
    
    func showToast(controller: UIViewController, message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }

}
