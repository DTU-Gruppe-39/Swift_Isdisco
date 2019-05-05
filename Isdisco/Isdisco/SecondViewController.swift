//
//  SecondViewController.swift
//  Isdisco
//
//  Created by Rasmus Gregersen on 04/03/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class SecondViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    let apiRequest = SearchAPIRequest()
    var isSearchActive : Bool = false
    var filtered:[Singleton.Track] = []
    var previousSearch = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.tableFooterView = UIView()
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Søg Spotify Sang"
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        tableViewBackgroundViewSetup()
    }
    
    private func tableViewBackgroundViewSetup ()
    {
        let label = UILabel (frame: .zero)
        label.text = "Ingen resultater..."
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font.withSize(20)
        label.textAlignment = NSTextAlignment.center
        tableView.backgroundView = label
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let trackCell = tableView.dequeueReusableCell(withIdentifier: "trackCell") as! TrackSearchTableCell
        print(indexPath.row)
        trackCell.song_name?.text = searchResults[indexPath.row]["SongName"].stringValue
        trackCell.artist?.text = searchResults[indexPath.row]["ArtistName"].stringValue
        if let urlToImage = searchResults[indexPath.row]["Image_small_url"].string {
            apiRequest.fetchImage(urlToImageToFetch: urlToImage, completionHandler: {
                image, _ in trackCell.albumImage?.image = image
            })
        }
        
        return trackCell
    }
    var valuesToPass:[String]!

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song_name = searchResults[indexPath.row][""].stringValue
        let artist = searchResults[indexPath.row][""].stringValue
        /*if let urlToImage = searchResults[indexPath.row]["thumnail"]["source"].string {
            apiRequest.fetchImage(urlToImageToFetch: urlToImage, completionHandler: {
                image, _ in trackCell.albumImage = image
            })
        }*/
        /*performSegue(withIdentifier: "searchSegueIdentifer", sender: self)
        */print("Values clicked: \(song_name)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "trackSegue" {
            guard let row = tableView.indexPathForSelectedRow?.row else {
                return
            }
            let segueViewController = segue.destination as? SegueForSearchResultViewController
            
            segueViewController?.song_name_text = searchResults[row]["SongName"].stringValue
            segueViewController?.artist_text = searchResults[row]["ArtistName"].stringValue
            segueViewController?.albumImage_url = searchResults[row]["Image_large_url"].stringValue
            segueViewController?.spotify_url_text = searchResults[row]["WebplayerLink"].stringValue
        }
    }
    
    private var searchResults = [JSON]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension SecondViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResults.removeAll()
        guard let textToSearch = searchBar.text, !textToSearch.isEmpty
            else {
                return
            }
        
        if Date().timeIntervalSince(previousSearch) > 0.5 {
            previousSearch = Date()
            updateResults(for: textToSearch)
        }
    }
    func updateResults (for searchText: String) {
        print("Search: \(searchText)")
        apiRequest.search(textToSearch: searchText, completionHandler: {
            [weak self] results, error in if case .failure = error {
                return
            }
            
            guard let results = results, !results.isEmpty else {
                return
            }
            self?.searchResults = results
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResults.removeAll()
    }
}
