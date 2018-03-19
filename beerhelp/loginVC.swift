//
//  loginVC.swift
//  beerhelp
//
//  Created by David Tosh on 27/07/17.
//  Copyright © 2017 David Tosh. All rights reserved.
//

import UIKit
import Firebase



class loginVC: UIViewController {
    
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    
    let loginToList = "loginToBuild"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: self.loginToList, sender: nil)
            
        }

    }
    }
    
      //login actions
    
    @IBAction func loginPressed(_ sender: Any) {
       
        Auth.auth().signIn(withEmail: usernameText.text!, password: passwordText.text!)
    }
    
    //sign in actions

    @IBAction func signUpPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Register", message: "Register", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            
            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]
            
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { user, error in
                
                if error == nil {
                    Auth.auth().signIn(withEmail: self.usernameText.text!, password: self.passwordText.text!)
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addTextField { textEmail in textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in textPassword.isSecureTextEntry = true
            
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }

    

}
