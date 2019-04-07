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
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func signupOrLogin(_ sender: Any) {
    }
    @IBOutlet weak var signupOrLoginButton: UIButton!
    @IBAction func switchLoginMode(_ sender: Any) {
    }
    @IBAction func switchLoginModeButton(_ sender: Any) {
    }
    @IBOutlet weak var switchLoginModeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

