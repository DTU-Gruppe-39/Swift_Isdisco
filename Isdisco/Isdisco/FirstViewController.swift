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
    
    var myTopResults = [TrackImage]() {
        didSet {
            myTableView.reloadData()
        }
    }
    var playlist1Results = [TrackImage]() {
        didSet {
            myTableView.reloadData()
        }
    }
    var playlist2Results = [TrackImage]() {
        didSet {
            myTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CategoryRow
        if indexPath.section == 0 {
            tableCell.updateCellWith(playlist: myTopResults)
            
        }
        else if indexPath.section == 1 {
            tableCell.updateCellWith(playlist: playlist1Results)
        }
        else if indexPath.section == 2 {
            tableCell.updateCellWith(playlist: playlist2Results)
        }
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
        apiRequest.topList(completionHandler: {
            [weak self] results, error in if case .failure = error {
                return
            }
            
            guard let results = results, !results.isEmpty else {
                return
            }
            for result in results {
                self?.myTopResults.append(TrackImage.jsonToObject(json: result))
            }
        })
        
        apiRequest.playlist(playlistId: 1, completionHandler: {
            [weak self] results, error in if case .failure = error {
                return
            }
            
            guard let results = results, !results.isEmpty else {
                return
            }
            for result in results {
                self?.playlist1Results.append(TrackImage.jsonToObject(json: result))
            }
        })
        
        apiRequest.playlist(playlistId: 2, completionHandler: {
            [weak self] results, error in if case .failure = error {
                return
            }
            
            guard let results = results, !results.isEmpty else {
                return
            }
            for result in results {
                self?.playlist2Results.append(TrackImage.jsonToObject(json: result))
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

