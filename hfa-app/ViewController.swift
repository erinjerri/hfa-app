//
//  ViewController.swift
//  hfa-app
//
//  Created by Erin Pangilinan on 10/14/15.
//  Copyright © 2015 Erin Pangilinan. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var occupationField: UITextField!
    
    
    @IBOutlet weak var employerField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Submit information to Parse API
    @IBAction func submitButton(sender: AnyObject) {
        
        let occupation = occupationField.text
        
        let employer = employerField.text
        
        let user = PFObject(className: "user")
        
        user["occupation"] = occupation
        user["employer"] = employer
        user.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Submitted has been saved.")
        }
    }
    
    @IBAction func tapBackground(sender: UITapGestureRecognizer) {
        occupationField.resignFirstResponder()
        employerField.resignFirstResponder()
    }
    
    func keyboardWillHide(notification: NSNotification!){
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func keyboardWillShow(notification:NSNotification){
    }

    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
}
