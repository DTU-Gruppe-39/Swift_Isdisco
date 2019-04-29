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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let testArray = Singleton.shared.tracks[indexPath.row]
        
        guard let trackCell = tableView.dequeueReusableCell(withIdentifier: "trackCell") as? TrackSearchTableCell else {
            return UITableViewCell()
        }
        trackCell.song_name.text = testArray.title
        trackCell.artist.text = testArray.title
        trackCell.albumImage.image = UIImage(named:"LOGO_ISDISCO")
        
        return trackCell
    }
}

