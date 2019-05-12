//
//  SecondViewController.swift
//  Isdisco
//
//  Created by Magnus Stjernborg Kochh on 04/05/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class SecondViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    let apiRequest = SearchAPIRequest()
    let fetchImage = FetchImageAPI()
    var isSearchActive : Bool = false
    var filtered:[Singleton.Track] = []
    var previousSearch = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.tableFooterView = UIView()
        navigationItem.title = "Search"
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Søg Spotify Sang"
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = true
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        tableViewBackgroundViewSetup()
        
        let viewController = self.tabBarController?.viewControllers?[1] as? SecondViewController
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
        trackCell.song_name?.text = searchResults[indexPath.row].songName
        trackCell.artist?.text = searchResults[indexPath.row].artistName
        fetchImage.fetchImage(urlToImageToFetch: searchResults[indexPath.row].image_medium_url, completionHandler: {
            image, _ in trackCell.albumImage?.image = image
        })
    
        return trackCell
    }
    var valuesToPass:[String]!

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Handled in storyboard with segue.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "trackSegue" {
            guard let row = tableView.indexPathForSelectedRow?.row else {
                return
            }
            let segueViewController = segue.destination as? SegueForSearchResultViewController
            
            segueViewController?.track = searchResults[row]
        }
    }
    
    private var searchResults = [Track]() {
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
            
            for result in results {
                self?.searchResults.append(Track.jsonToObject(json: result))
            }
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResults.removeAll()
    }
}
