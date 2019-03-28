//
//  NowPlayingViewController.swift
//  Isdisco
//
//  Created by Thomas Mattsson on 28/03/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController {

    @IBOutlet weak var albumArt: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.songTitle.text = Singleton.shared.tracks[0].title
        
        
        // Do any additional setup after loading the view.
    }
    

}
