//
//  ViewController.swift
//  MargatsIn
//
//  Created by 板垣智也 on 2019/04/05.
//  Copyright © 2019 板垣智也. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    var signupModeActive = true
    
    func displayAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func signupOrLogin(_ sender: Any) {
        if email.text == "" || password.text == "" {
            
            displayAlert(title: "Error in form", message: "Please an email and password")
            
        } else {
            
            // Spinner
            // Create Indicator
            let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            
            activityIndicator.center = self.view.center
            
            activityIndicator.hidesWhenStopped = true
            
            activityIndicator.style = UIActivityIndicatorView.Style.gray
            
            // Add indicator to view
            view.addSubview(activityIndicator)
            
            activityIndicator.startAnimating()
            
            // User cannot press the button
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            if (signupModeActive) {
                print("Signing Up...")
                
                let user = PFUser()
                
                user.username = email.text
                user.password = password.text
                user.email = email.text
                // other fields can be set just like with PFObject
//                user["phone"] = "415-392-0202"
                
                user.signUpInBackground(block: {(success, error) in
                    
                    // Handle Indicator
                    activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if let error = error {
                        
                        self.displayAlert(title: "Could not sign you up", message: error.localizedDescription)
//                        let errorString = error.userInfo["error"] as? NSString
                        // Show the errorString somewhere and let the user try again.
                        print(error)
                    } else {
                        print("Signed Up!")
                        
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                    }
                })
            } else {
                print("Loging in...")
                
                // Handle Indicator
                activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                PFUser.logInWithUsername(inBackground: email.text!, password: password.text!, block: { (user, error) in
                    
                    if user != nil {
                        print ("Login successful!")
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                    } else {
                        var errorText = "Unknown error: please try again"
                        
                        if let error = error {
                            errorText = error.localizedDescription
                        }
                        
                        self.displayAlert(title: "Could not sign you up", message: errorText)
                    }
                })
            }
        }
    }
    @IBOutlet weak var signupOrLoginButton: UIButton!
    @IBAction func switchLoginMode(_ sender: Any) {
    }
    @IBAction func switchLoginModeButton(_ sender: Any) {
        if (signupModeActive) {
            signupModeActive = false
            
            signupOrLoginButton.setTitle("Log In", for: [])
            
            switchLoginModeButton.setTitle("Sign Up", for: [])
        } else {
            signupModeActive = true
            signupOrLoginButton.setTitle("Sign Up", for: [])
            
            switchLoginModeButton.setTitle("Log In", for: [])
        }
    }
    @IBOutlet weak var switchLoginModeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidAppear(_ animated: Bool) {
        
        if PFUser.current() != nil {
            self.performSegue(withIdentifier: "showUserTable", sender: self)
        }
        
        self.navigationController?.navigationBar.isHidden = true
    }
}

