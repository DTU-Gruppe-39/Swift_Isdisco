//
//  LoginViewController.swift
//  Isdisco
//
//  Created by Rasmus Gregersen on 10/03/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var idStepper: UIStepper!
    var id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Singleton.shared.setUpData()

        // Do any additional setup after loading the view.
        
        idLabel.text = "ID: \(id)"
        
        idStepper.wraps = true
        idStepper.autorepeat = true
        idStepper.maximumValue = 9
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        idLabel.text = "ID: \(Int(sender.value).description)"
        id = Int(sender.value)
    }
    
    
    @IBAction func fbLogin(_ sender: UIButton) {
        Singleton.shared.currentUserId = id
        self.performSegue(withIdentifier: "ExitLogInSignUp", sender: nil)
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
