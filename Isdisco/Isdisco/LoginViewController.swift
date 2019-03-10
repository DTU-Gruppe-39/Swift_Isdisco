//
//  LoginViewController.swift
//  Isdisco
//
//  Created by Rasmus Gregersen on 10/03/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func fbLogin(_ sender: UIButton) {
    }
    
    @IBAction func devLogin(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ExitLogInSignUp", sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
