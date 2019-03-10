//
//  FirstViewController.swift
//  Isdisco
//
//  Created by Rasmus Gregersen on 04/03/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    var loggedIn = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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

