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

class CategoryRow : UITableViewCell {
    var currentPlaylist : [Track]?
    weak var categoryRowDelegate:CollectionCellDelegate?
    @IBOutlet weak var myCollectionView: UICollectionView!

    func updateCellWith (playlist: [Track]) {
        self.currentPlaylist = playlist
        print("playlist \(currentPlaylist)")
        self.myCollectionView.reloadData()
    }
    
}

protocol CollectionCellDelegate:class {
    func collectionView(trackCell:FrontPageRowCell?, didTappedInTableview TableCell:CategoryRow)
}

extension CategoryRow : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentPlaylist!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let trackCell = collectionView.cellForItem(at: indexPath) as? FrontPageRowCell
        self.categoryRowDelegate?.collectionView(trackCell: trackCell, didTappedInTableview: self)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let trackCell = collectionView.dequeueReusableCell(withReuseIdentifier: "trackCell", for: indexPath) as! FrontPageRowCell
        if let track = self.currentPlaylist?[indexPath.item] {
            trackCell.updateCell(track: track)
        }
        return trackCell
    }
}

extension CategoryRow : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 2.5
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
