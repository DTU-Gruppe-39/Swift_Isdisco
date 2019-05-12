//
//  LiveTableViewController.swift
//  Isdisco
//
//  Created by Rasmus Gregersen on 18/03/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LiveTableViewController: UITableViewController, LiveTableViewCellDelegate {
    //class LiveTableViewController: UITableViewController {
    
    let musicRequestAPI = MusicReqeustAPIRequest()
    var musicRequests = [MusicRequest]()
    
    let fetchImageAPI = FetchImageAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 10.0, *) {
            let refreshControl = UIRefreshControl()
            let title = "Træk for at genindlæse"
            refreshControl.attributedTitle = NSAttributedString(string: title)
            refreshControl.addTarget(self,
                                     action: #selector(refreshOptions(sender:)),
                                     for: .valueChanged)
            tableView.refreshControl = refreshControl
        }
        // set observer for UIApplication.willEnterForegroundNotification
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    // my selector that was defined above
    @objc func willEnterForeground() {
        musicRequestAPI.FetchMusicRequests() { response in
            //            let musicRequests = response
            self.musicRequests = response
            //            print("Sangen er: ", self.musicRequests[3].track.songName)
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool){
        
        musicRequestAPI.FetchMusicRequests() { response in
            //            let musicRequests = response
            self.musicRequests = response
            //            print("Sangen er: ", self.musicRequests[3].track.songName)
            self.tableView.reloadData()
        }
    }
    
    //Pull to refresh function
    @objc func refreshOptions(sender: UIRefreshControl) {
        musicRequestAPI.FetchMusicRequests() { response in
            //            let musicRequests = response
            self.musicRequests = response
            //            print("Sangen er: ", self.musicRequests[3].track.songName)
            
            self.tableView.reloadData()
            
            self.delay(0.1, closure: {
                print("It has finished")
                sender.endRefreshing()
            })
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return Singleton.shared.songRequests.count
        return musicRequests.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LiveCell", for: indexPath) as! LiveTableViewCell
        
        //Look into https://cocoapods.org/pods/MarqueeLabel
        //It scrolls the text if it is too long to fit
        //        cell.songName.text = "This is the row number \(indexPath.row)."
        //        cell.voteCount.text = String(Int.random(in: 0 ... 15))
        
        
        //        let request = Singleton.shared.songRequests[indexPath.row]
        let request = musicRequests[indexPath.row]
        
        //Setting the picture
        self.fetchImageAPI.fetchImage(urlToImageToFetch: request.track.image_medium_url, completionHandler: {
            image, _ in cell.songImage?.image = image
        })
        
        cell.songName.text = request.track.songName
        cell.artist.text = request.track.artistName
        cell.userName.text = request.upvoteUsers![0].fullname
        cell.timeAgo.text = String(request.timestamp) + " min ago"
        cell.voteCount.text = String(request.upvotes!.count - request.downvotes!.count)
        
        
        ThumbsUpDown(request, cell)
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
        
        //        let request = Singleton.shared.songRequests[tappedIndexPath.row]
        let request = musicRequests[tappedIndexPath.row]
        let cell = tableView.cellForRow(at: tappedIndexPath) as! LiveTableViewCell
        
        
        if (request.upvotes!.contains(Singleton.shared.currentUserId)) {
            //remove upVote
            //Delete
            //https://isdisco.azurewebsites.net/api/musicrequest/{id}/upvote/{userid}
        } else {
            //Add upvote
            //PUT
            //https://isdisco.azurewebsites.net/api/musicrequest/{id}/upvote/{userid}
            Alamofire.request("https://isdisco.azurewebsites.net/api/musicrequest/\(request.id)/upvote/\(Singleton.shared.currentUserId)", method: .put, encoding: JSONEncoding.default).responseJSON { response in
                //Fix failure and success
                switch response.response?.statusCode {
                case 200:
                    cell.upVoteButtone.isEnabled = false
                    cell.downVoteButton.isEnabled = false
                    cell.upVoteButtone.tintColor = UIColor.lightGray
                    cell.downVoteButton.isHidden = true
                    cell.upVoteButtone.isHidden = false
                    cell.voteCount.text = String(Int(cell.voteCount.text!)! + 1)
                case 500:
                    print("FAILED: Upvote gik galt")
                case .none:
                    print("FAILED: Upvote gik galt_1")
                case .some(_):
                    print("FAILED: Upvote gik galt_2")
                }
            }
        }
        
        
        
        
        
        
        //        if (request.upvotes!.contains(Singleton.shared.currentUserId) || request.downvotes!.contains(Singleton.shared.currentUserId)) {
//            if (request.upvotes!.contains(Singleton.shared.currentUserId)) {
//                //request.voted = false
//                //request.upVoted = false
//
//                cell.upVoteButtone.isEnabled = true
//                cell.downVoteButton.isEnabled = true
//                cell.upVoteButtone.tintColor = UIColor.darkGray
//                cell.downVoteButton.isHidden = false
//                //request.votes -= 1
//                //sender.voteCount.text = String(request.votes)
//
//            } else {
//
//                //request.voted = true
//                //request.upVoted = true
//
//                cell.upVoteButtone.isEnabled = false
//                cell.downVoteButton.isEnabled = false
//                cell.upVoteButtone.tintColor = UIColor.lightGray
//                cell.downVoteButton.isHidden = true
//                //request.votes += 1
//                //sender.voteCount.text = String(request.votes)
//
//            }
//        }
    }
    func liveTableViewCellDidDownVote(_ sender: LiveTableViewCell) {
        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
        print("You just DownVoted a song", sender, tappedIndexPath)
        
        //        let request = Singleton.shared.songRequests[tappedIndexPath.row]
        let request = musicRequests[tappedIndexPath.row]
        let cell = tableView.cellForRow(at: tappedIndexPath) as! LiveTableViewCell
        
        //        if request.voted {
        //            request.voted = false
        //            request.upVoted = false
        //
        ////            cell.downVoteButton.isEnabled = true
        ////            cell.upVoteButtone.isEnabled = true
        //            cell.downVoteButton.tintColor = UIColor.darkGray
        //            cell.upVoteButtone.isHidden = false
        //            request.votes += 1
        //            cell.voteCount.text = String(request.votes)
        //        } else {
        //            request.voted = true
        //            request.upVoted = false
        //
        ////            cell.downVoteButton.isEnabled = false
        ////            cell.upVoteButtone.isEnabled = false
        //            cell.downVoteButton.tintColor = UIColor.lightGray
        //            cell.upVoteButtone.isHidden = true
        //            request.votes -= 1
        //            cell.voteCount.text = String(request.votes)
        //        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    fileprivate func ThumbsUpDown(_ request: MusicRequest, _ cell: LiveTableViewCell) {
        if (request.upvotes!.contains(Singleton.shared.currentUserId) || request.downvotes!.contains(Singleton.shared.currentUserId)) {
            if (request.upvotes!.contains(Singleton.shared.currentUserId)) {
                cell.upVoteButtone.isEnabled = false
                cell.downVoteButton.isEnabled = false
                cell.upVoteButtone.tintColor = UIColor.lightGray
                cell.downVoteButton.isHidden = true
                cell.upVoteButtone.isHidden = false
            } else if (request.downvotes!.contains(Singleton.shared.currentUserId)) {
                cell.downVoteButton.isEnabled = false
                cell.upVoteButtone.isEnabled = false
                cell.downVoteButton.tintColor = UIColor.lightGray
                cell.upVoteButtone.isHidden = true
                cell.downVoteButton.isHidden = false
            }
        } else {
            cell.downVoteButton.isEnabled = true
            cell.upVoteButtone.isEnabled = true
            cell.upVoteButtone.tintColor = UIColor.darkGray
            cell.downVoteButton.tintColor = UIColor.darkGray
            cell.upVoteButtone.isHidden = false
            cell.downVoteButton.isHidden = false
        }
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
