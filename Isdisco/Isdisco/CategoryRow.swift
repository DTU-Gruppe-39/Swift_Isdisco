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
    let apiRequest = PlaylistAPIRequest()
    let fetchImageAPI = FetchImageAPI()
    private var topListResults = [Track]()
    private var playlist1Results = [Track]()
    private var playlist2Results = [Track]()
}

extension CategoryRow : UICollectionViewDataSource {
    //For test purposes
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let trackCell = collectionView.dequeueReusableCell(withReuseIdentifier: "trackCell", for: indexPath) as! FrontPageRowCell
        print(indexPath.row)
        
        if 0...10 ~= indexPath.row {
            apiRequest.topList(completionHandler: {
                [weak self] results, error in if case .failure = error {
                    return
                }
                
                guard let results = results, !results.isEmpty else {
                    return
                }
                for result in results {
                    self?.topListResults.append(Track.jsonToObject(json: result))
                    trackCell.song_name?.text = self?.topListResults[indexPath.row].songName
                    self!.fetchImageAPI.fetchImage(urlToImageToFetch: self!.topListResults[indexPath.row].image_small_url, completionHandler: {
                        image, _ in trackCell.albumImage?.image = image
                    })
                }
            })
        }
        
        /*
        apiRequest.playlist(playlistId: 1, completionHandler: {
            [weak self] results, error in if case .failure = error {
                return
            }
            
            guard let results = results, !results.isEmpty else {
                return
            }
            for result in results {
                self?.playlist1Results.append(Track.jsonToObject(json: result))
                trackCell.song_name?.text = self?.playlist1Results[indexPath.row].songName
                self!.fetchImageAPI.fetchImage(urlToImageToFetch: self!.topListResults[indexPath.row].image_small_url, completionHandler: {
                    image, _ in trackCell.albumImage?.image = image
                })
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
                self?.playlist2Results.append(Track.jsonToObject(json: result))
                
                trackCell.song_name?.text = self?.playlist2Results[indexPath.row].songName
                self!.fetchImageAPI.fetchImage(urlToImageToFetch: self!.topListResults[indexPath.row].image_small_url, completionHandler: {
                    image, _ in trackCell.albumImage?.image = image
                })
            }
        })*/
        
        
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
