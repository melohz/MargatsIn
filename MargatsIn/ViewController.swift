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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /* Lecture 111-112
        // Sample code from Parse Server document
        let gameScore = PFObject(className:"GameScore")
        gameScore["score"] = 1337
        gameScore["playerName"] = "Sean Plott"
        gameScore["cheatMode"] = false
        gameScore.saveInBackground {
            (success: Bool, error: Error?) in
            if (success) {
                // The object has been saved.
                print("Success")
            } else {
                // There was a problem, check error.description
                print("Failed")
            }
 
        }
        */
        
        /* Lecture 113
        let comment = PFObject(className: "Comment")
        comment["text"] = "good shot"
        comment.saveInBackground {
            (success, error) in
            if (success) {
                print("Save successful!")
            } else {
                print("Save failed")
            }
        }
        */
        
        // Fetch the data and update comment
        let query = PFQuery(className: "Comment")
        query.getObjectInBackground(withId: "qHpAwR137o") { (object, error) in
            if let comment = object {
                print(comment)
                comment["text"] = "Awful!"
                comment.saveInBackground(block: { (success, error) in
                    if (success) {
                        print("Successfully updated")
                    } else {
                        print("Failed to update")
                    }
                })
            } else {
                print("failed to fetch the data")
            }
        }
    }
}

