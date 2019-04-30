//
//  FirstViewController.swift
//  Isdisco
//
//  Created by Rasmus Gregersen on 04/03/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import UIKit
import UserNotifications

class FirstViewController: UIViewController, UITableViewDataSource {
    
    var categories = ["Hot tracks", "Favorites", "Recently played"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CategoryRow
        
        return tableCell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    

    var loggedIn = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       /*
        let content = UNMutableNotificationContent()
        content.title = "Title"
        content.body = "Body"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "testIdentifier", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !loggedIn {
            self.performSegue(withIdentifier: "LogInSignUp", sender: self)
        }
    }
    
    // This is the target of the unwind segue
    @IBAction func finishedLoggingIn(segue: UIStoryboardSegue) {
        loggedIn = true
        print("logged in and ready to go!")
    }


}

