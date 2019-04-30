//
//  TrackSearchTableCell.swift
//  Isdisco
//
//  Created by Magnus Stjernborg Koch on 23/04/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import UIKit

class TrackSearchTableCell: UITableViewCell {
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var song_name: UILabel!
    @IBOutlet weak var artist: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
