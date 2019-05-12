//
//  LiveTableViewController.swift
//  Isdisco
//
//  Created by Rasmus Gregersen on 18/03/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import UIKit

class LiveTableViewController: UITableViewController, LiveTableViewCellDelegate {
//class LiveTableViewController: UITableViewController {

    let musicRequestAPI = MusicReqeustAPIRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var musicRequests: [MusicRequest]?
        
        /*
        musicRequests = musicRequestAPI.FetchMusicRequests(completion: { error in
            if error != nil {
                print("Oops! Something went wrong...")
            } else {
                print("It has finished")
            }
        })
        print("\(musicRequests![0].track.songName)")
         */
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Singleton.shared.songRequests.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LiveCell", for: indexPath) as! LiveTableViewCell
        
        //Look into https://cocoapods.org/pods/MarqueeLabel
        //It scrolls the text if it is too long to fit
//        cell.songName.text = "This is the row number \(indexPath.row)."
//        cell.voteCount.text = String(Int.random(in: 0 ... 15))
        
        
        let request = Singleton.shared.songRequests[indexPath.row]
        cell.songName.text = request.track.title
        cell.artist.text = request.track.artist
        cell.userName.text = request.user.name
        cell.timeAgo.text = String(request.timeStamp) + " min ago"
        cell.voteCount.text = String(request.votes)
        if request.voted {
            if request.upVoted {
//                cell.upVoteButtone.isEnabled = false
//                cell.downVoteButton.isEnabled = false
                cell.upVoteButtone.tintColor = UIColor.lightGray
                cell.downVoteButton.isHidden = true
                cell.upVoteButtone.isHidden = false
            } else {
//                cell.downVoteButton.isEnabled = false
//                cell.upVoteButtone.isEnabled = false
                cell.downVoteButton.tintColor = UIColor.lightGray
                cell.upVoteButtone.isHidden = true
                cell.downVoteButton.isHidden = false
            }
        } else {
//            cell.downVoteButton.isEnabled = true
//            cell.upVoteButtone.isEnabled = true
            cell.upVoteButtone.tintColor = UIColor.darkGray
            cell.downVoteButton.tintColor = UIColor.darkGray
            cell.upVoteButtone.isHidden = false
            cell.downVoteButton.isHidden = false
        }
        

        
        
        
        
        cell.delegate = self

        // Configure the cell...
        //cell.imageView?.image =
        return cell
    }
 
    
    func liveTableViewCellDidUpVote(_ sender: LiveTableViewCell) {
        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
        print("You just UpVoted a song", sender, tappedIndexPath)
//        let cell = tableView.cellForRow(at: tappedIndexPath) as! LiveTableViewCell
//        let count = cell.voteCount.text
//        cell.voteCount.text = cell.voteCount.text
        
        let request = Singleton.shared.songRequests[tappedIndexPath.row]
        let cell = tableView.cellForRow(at: tappedIndexPath) as! LiveTableViewCell
        
        if request.voted {
            if request.upVoted {
                request.voted = false
                request.upVoted = false
                
//                cell.upVoteButtone.isEnabled = true
//                cell.downVoteButton.isEnabled = true
                cell.upVoteButtone.tintColor = UIColor.darkGray
                cell.downVoteButton.isHidden = false
                request.votes -= 1
                sender.voteCount.text = String(request.votes)
            }
        } else {
            request.voted = true
            request.upVoted = true
            
//            cell.upVoteButtone.isEnabled = false
//            cell.downVoteButton.isEnabled = false
            cell.upVoteButtone.tintColor = UIColor.lightGray
            cell.downVoteButton.isHidden = true
            request.votes += 1
            sender.voteCount.text = String(request.votes)
            
        }
    }

    func liveTableViewCellDidDownVote(_ sender: LiveTableViewCell) {
        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
        print("You just DownVoted a song", sender, tappedIndexPath)
        
        let request = Singleton.shared.songRequests[tappedIndexPath.row]
        let cell = tableView.cellForRow(at: tappedIndexPath) as! LiveTableViewCell
        
        if request.voted {
            request.voted = false
            request.upVoted = false
            
//            cell.downVoteButton.isEnabled = true
//            cell.upVoteButtone.isEnabled = true
            cell.downVoteButton.tintColor = UIColor.darkGray
            cell.upVoteButtone.isHidden = false
            request.votes += 1
            cell.voteCount.text = String(request.votes)
        } else {
            request.voted = true
            request.upVoted = false
            
//            cell.downVoteButton.isEnabled = false
//            cell.upVoteButtone.isEnabled = false
            cell.downVoteButton.tintColor = UIColor.lightGray
            cell.upVoteButtone.isHidden = true
            request.votes -= 1
            cell.voteCount.text = String(request.votes)
        }
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
