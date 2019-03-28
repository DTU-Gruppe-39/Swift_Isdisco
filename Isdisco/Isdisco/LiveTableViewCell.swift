//
//  LiveTableViewCell.swift
//  Isdisco
//
//  Created by Rasmus Gregersen on 18/03/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import UIKit

class LiveTableViewCell: UITableViewCell {

    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var timeAgo: UILabel!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var voteCount: UILabel!
    @IBOutlet weak var upVoteButtone: UIButton!
    @IBOutlet weak var downVoteButton: UIButton!
    
//    weak var delegate: LiveTableViewCellDelegate?
    
//    var upVoteReconizer = UITapGestureRecognizer(target: self, action: Selector(("handleUpVote")))
//    upVoteReconizer.delegate = self
//    self.upVote.addGestureReconizer(UITapReconizer)
//    
//    func handleUpVote(sender: AnyObject) {
//        print("You pressed up vote!")
//    }
    
    
    @IBAction func upVoteButtone(_ sender: UIButton) {
//        delegate?.liveTableViewCellDidUpVote(self)
//        print("You pressed upvote")
        self.voteCount.text = "3337"
    }

    @IBAction func downVoteButton(_ sender: UIButton) {
//        delegate?.liveTableViewCellDidDownVote(self)
//        print("You pressed downvote")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


//protocol LiveTableViewCellDelegate : class {
//    func liveTableViewCellDidUpVote(_ sender: LiveTableViewCell)
//    func liveTableViewCellDidDownVote(_ sender: LiveTableViewCell)
//}
