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
    @IBOutlet weak var OpenInSpotifyButton: UIButton!
    @IBOutlet weak var requestTrackButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    var track:Track?
    var paramters :[String:Track]?
    
    let apiRequest = SearchAPIRequest()
    let fetchImage = FetchImageAPI()
    var navigationControllerBool = true
    
    override func viewWillAppear(_ animated: Bool) {
        if track == nil {
            self.track = paramters!["track"]
            navigationControllerBool = false
            closeButton.isHidden = false
            closeButton.isEnabled = true
        }
        else {
            navigationControllerBool = true
            closeButton.isHidden = true
            closeButton.isEnabled = false
        }
        song_name.text = track?.songName
        artist.text = track?.artistName
        
        fetchImage.fetchImage(urlToImageToFetch: track!.image_large_url, completionHandler: {
            image, _ in self.albumImage?.image = image
        })

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestTrackButton.layer.cornerRadius = 8
        OpenInSpotifyButton.layer.cornerRadius = 8
        
        requestTrackButton.layer.borderWidth = 1.5
        OpenInSpotifyButton.layer.borderWidth = 1.5
        
        requestTrackButton.layer.borderColor = UIColor(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1.0).cgColor
        OpenInSpotifyButton.layer.borderColor = UIColor(red: 30/255.0, green: 215/255.0, blue: 96/255.0, alpha: 1.0).cgColor
        // Do any additional setup after loading the view.
    }

    
    @IBAction func requestTrack(_ unwindSegue: UIStoryboardSegue) {
        if (navigationControllerBool) {
            let musicrequest = Musicrequest.init(track: self.track!, userId: Singleton.shared.currentUserId)
            Alamofire.request("https://isdisco.azurewebsites.net/api/musicrequest", method: .post, parameters: Musicrequest.objectToJson(object: musicrequest), encoding: JSONEncoding.default).responseJSON { response in
                //Fix failure and success
                switch response.response?.statusCode {
                case 200:
                    self.navigationController?.popViewController(animated: true)
                    self.showToast(controller: self.parent!, message: "Musik forespørgelse er sendt!", seconds: 1)
                case 500:
                    self.navigationController?.popViewController(animated: true)
                    self.showToast(controller: self.parent!, message: "Sangen var allerede ønsket. Vi har upvoted sangen", seconds: 3)
                case .none:
                    print("none statuscode retuned")
                case .some(_):
                    print("not expected statuscode")
                }
            }
        }
        else {
            let musicrequest = Musicrequest.init(track: self.track!, userId: Singleton.shared.currentUserId)
            let firstViewController = self.presentingViewController!
            Alamofire.request("https://isdisco.azurewebsites.net/api/musicrequest", method: .post, parameters: Musicrequest.objectToJson(object: musicrequest), encoding: JSONEncoding.default).responseJSON { response in
                //Fix failure and success
                switch response.response?.statusCode {
                case 200:
                    self.dismiss(animated: true) {
                        self.showToast(controller: firstViewController, message: "Musik forespørgelse er sendt", seconds: 1)
                    }
                case 500:
                    self.dismiss(animated: true) {
                        self.showToast(controller: firstViewController, message: "Sangen var allerede ønsket. Vi har upvoted sangen", seconds: 3)
                    }
                case .none:
                    print("none statuscode retuned")
                case .some(_):
                    print("not expected statuscode")
                }
            }
        }
    }
    
    @IBAction func closeButton(_ unwindSegue: UIStoryboardSegue) {
        self.dismiss(animated: true)
    }
    
    @IBAction func OpenInSpotify(_ sender: Any) {
        let url = URL(string: track!.webplayerLink)
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
