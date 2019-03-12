//
//  PopUpViewController.swift
//  Isdisco
//
//  Created by Thomas Mattsson on 12/03/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        // self.showAnimate()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelPopUp(_ sender: UIButton) {
        dismiss(animated: true)
    }

    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.15, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.15, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
  

}
