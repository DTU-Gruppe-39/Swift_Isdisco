//
//  FeedbackViewController.swift
//  Isdisco
//
//  Created by Thomas Mattsson on 03/04/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FeedbackViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
   
    @IBOutlet weak var tagsPickerView: UIPickerView!
    
    @IBOutlet weak var editText: UITextView!
    
    //Array of what appears in the pickerView.
    let tags = ["Generelt", "Lyd/lys", "Personale", "Andet"]
    let URL = "https://isdisco.azurewebsites.net/api/feedback/uploadfeedback"
    
    let feedbackUser = User.init(id: 1, fullname: "Thomas Mattsson", vip: false, loginDetails: LoginDetails.init(username: "Thomas", password: "123"), appToken: "", facebookToken: "")

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tags[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tags.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(tags[row])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Make the "Done button" appear atop the keyboard
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Færdig", style: .done, target: self, action: #selector(self.doneAction))
        
        //Makes the "Færdig" button appear on the right
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolbar.items = [flexibleSpace ,doneButton]
        
        editText.inputAccessoryView = toolbar
        editText.placeholder = "Skriv din feedback..."
        
        
    }
    
    //Defines what happens when "Færdig" is pressed
    @objc func doneAction() {
        editText.resignFirstResponder()
    }
    
    @IBAction func sendFeedback(_ sender: UIButton) {
        let myString : String = editText.text
        print(myString)
        sendFeedbackHTTP()
        //TODO: Loading while feedback is being sent. Then show toast.
        showToast(controller: self, message: "Din feedback er sendt", seconds: 1)
        
    }
    
    func showToast(controller: UIViewController, message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    func sendFeedbackHTTP(){
        //TODO: Add method to post JSON version of feedback.
        
        
        
        let feedback = Feedback.init(user: feedbackUser, tag: "Generelt", message: "Ultra nice event")
        print(Feedback.objectToJson(object: feedback))
        
        let parameters = Feedback.objectToJson(object: feedback)

        Alamofire.request(URL,
                          method:.post,
                          parameters: parameters,
                          encoding:JSONEncoding.default
                          )
 
    }
}
