//
//  SecondViewController.swift
//  Isdisco
//
//  Created by Rasmus Gregersen on 04/03/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var testArray = [Singleton.Track]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupTestArray()
    }
    
    func setupTestArray () {
        testArray.append(Singleton.Track(title: "Despacito" , artist: "Luis Fonsi", genre: "Pop", albumArt: "URL", trackId: 0))
        testArray.append(Singleton.Track(title: "American Idiot", artist: "Green Day", genre: "Rock", albumArt: "URL", trackId: 1))
        testArray.append(Singleton.Track(title: "7 Rings", artist: "Ariana Grande", genre: "Pop", albumArt: "URL", trackId: 2))
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let trackCell = tableView.dequeueReusableCell(withIdentifier: "trackCell") as? TrackSearchTableCell else {
            return UITableViewCell()
        }
        trackCell.song_name.text = testArray[indexPath.row].title
        trackCell.artist.text = testArray[indexPath.row].title
        trackCell.albumImage.image = UIImage(named:"LOGO_ISDISCO")
        
        return trackCell
    }
}

