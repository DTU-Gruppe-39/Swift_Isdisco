//
//  FrontPageRowCell.swift
//  Isdisco
//
//  Created by Magnus Stjernborg Koch on 30/04/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import UIKit

class FrontPageRowCell: UICollectionViewCell {
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var song_name: UILabel!
    
    let fetchImageAPI = FetchImageAPI()
    var currentTrack:Track!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(track :Track) {
        song_name.text = track.songName
        currentTrack = track
        
        fetchImageAPI.fetchImage(urlToImageToFetch: track.image_large_url, completionHandler: {
            image, _ in self.albumImage?.image = image
        })
    }
}
