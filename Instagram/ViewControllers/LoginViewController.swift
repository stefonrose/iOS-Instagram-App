//
//  LoginViewController.swift
//  Instagram
//
//  Created by Stephon Fonrose on 12/6/18.
//  Copyright © 2018 Stephon Fonrose. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameErrorLabel: UILabel!
    
    let alertController = UIAlertController(title: "Unable to create account", message: "Your device is not connected to the internet.", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameErrorLabel.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = userNameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) {
            (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                //print("User logged in successfully")
                // display view controller that needs to shown after successful login
            }
        }
        
    }
    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        
        newUser.username = userNameField.text
        newUser.password = passwordField.text
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                if error._code == 202 {
                    self.usernameErrorLabel.isHidden = false
                    //print("Username is already taken!")
                }
            } else {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)                //print("Yay, created a user!")
            }
        }
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
