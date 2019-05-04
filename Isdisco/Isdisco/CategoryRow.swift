//
//  CategoryRow.swift
//  Isdisco
//
//  Created by Magnus Stjernborg Koch on 23/04/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CategoryRow : UITableViewCell{
    let apiRequest = SearchAPIRequest()
    private var topListResults = [JSON]()
    private var newSongsResults = [JSON]()
    private var latestSongsResults = [JSON]()
    
    func getTopList () {
        apiRequest.search(textToSearch: "Jo", completionHandler: {
            [weak self] results, error in if case .failure = error {
                return
            }
            
            guard let results = results, !results.isEmpty else {
                return
            }
            self?.topListResults = results
        })
    }
    
    func getNewSongs () {
        apiRequest.search(textToSearch: "Kl", completionHandler: {
            [weak self] results, error in if case .failure = error {
                return
            }
            
            guard let results = results, !results.isEmpty else {
                return
            }
            self?.newSongsResults = results
        })
    }
    
    func getLatestSongs () {
        apiRequest.search(textToSearch: "He", completionHandler: {
            [weak self] results, error in if case .failure = error {
                return
            }
            
            guard let results = results, !results.isEmpty else {
                return
            }
            self?.latestSongsResults = results
        })
    }
    
}

extension CategoryRow : UICollectionViewDataSource {
    //For test purposes
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let trackCell = collectionView.dequeueReusableCell(withReuseIdentifier: "trackCell", for: indexPath)
        
        return trackCell
    }
}

extension CategoryRow : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 4
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
