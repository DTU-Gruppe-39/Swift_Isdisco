//
//  FirstViewController.swift
//  Isdisco
//
//  Created by Rasmus Gregersen on 04/03/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import UIKit
import UserNotifications

class FirstViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    var categories = ["Vores udvalg", "Top 50 Danmark", "Ja Dak"]
    let apiRequest = PlaylistAPIRequest()
    let fetchImageAPI = FetchImageAPI()
    var playlist1Results = [TrackImage]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CategoryRow
        tableCell.updateCellWith(playlist: playlist1Results)
        return tableCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }

    var loggedIn = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        data()
        self.myTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !loggedIn {
            self.performSegue(withIdentifier: "LogInSignUp", sender: self)
        }
    }
    
    func data () {
        apiRequest.playlist(playlistId: 1, completionHandler: {
            [weak self] results, error in if case .failure = error {
                return
            }
            
            guard let results = results, !results.isEmpty else {
                return
            }
            for result in results {
                print("kqly \(result)")
                self?.playlist1Results.append(TrackImage.jsonToObject(json: result))
                    for track in self!.playlist1Results {
                        self!.fetchImageAPI.fetchImage(urlToImageToFetch: track.image_medium_url, completionHandler: {
                            image, _ in track.fetchedImage
                        })
                    }
            }
        })
    }
    
    // This is the target of the unwind segue
    @IBAction func finishedLoggingIn(segue: UIStoryboardSegue) {
        loggedIn = true
        print("logged in and ready to go!")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "trackSegue") {
            
        }
    }


}

