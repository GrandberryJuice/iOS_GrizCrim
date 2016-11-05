//
//  ViewController.swift
//  GrizCrimeApp
//
//  Created by KENNETH GRANDBERRY on 6/5/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import pop
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase


class LoginVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var emailtxtField:UITextField!
    @IBOutlet weak var passwordtxtField:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        emailtxtField.attributedPlaceholder = NSAttributedString(string:"Email", attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        passwordtxtField.attributedPlaceholder = NSAttributedString(string:"Password", attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        
        emailtxtField.textColor = UIColor.whiteColor()
        passwordtxtField.textColor = UIColor.whiteColor()
       // UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        if let email = NSUserDefaults.standardUserDefaults().valueForKey("email") as? String,
            let password = NSUserDefaults.standardUserDefaults().valueForKey("password") as? String {
            emailtxtField.text = email
            passwordtxtField.text = password
            login()
        }
    
    }
    
    //MARK: Facebook login
//    @IBAction func fbBtnPressed(sender:UIButton!) {
//        //let ref = URL_BASE
//        let facebookLogin = FBSDKLoginManager()
//        // not being used at the moment
//        // Firebase 17999 error issue
//        facebookLogin.logInWithReadPermissions(["email"], fromViewController: self) { (facebookResult, facebookError) -> Void in
//            if facebookError != nil {
//                print("Facebook login failed. Error \(facebookError)")
//            } else if facebookResult.isCancelled {
//                print("Facebook login was cancelled")
//            } else {
//                let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
//                FIRAuth.auth()?.signInWithCredential(credential) { user, error in
//                    if error != nil {
//                        print("Login failed. \(error)")
//                    } else {
//                        print("Logged in! \(user)")
//                        let userData = ["provider": "Facebook"]
//                        DataService.ds.createFirebaseUser(user!.uid, user: userData)
//                        NSUserDefaults.standardUserDefaults().setValue(user!.uid, forKey: KEY_UID)
//                        self.performSegueWithIdentifier("ProfileVC", sender: nil)
//                    }
//                }
//            }
//        }
//    }
    
    //MARK: Email sign in
    @IBAction func Login_Signup(sender: AnyObject) {
        FIRAuth.auth()?.createUserWithEmail(emailtxtField.text!, password: passwordtxtField.text!, completion: {
        user, error in
            if error != nil{
                self.login()
            } else {
                print("User Created")
                self.login()
            }
        
        })
    }
    
    //MARK: Login in User
    func login() {
        FIRAuth.auth()?.signInWithEmail(emailtxtField.text!, password: passwordtxtField.text!, completion: {
        user, error in
            if error != nil {
                print(error)
                if error!.code == STATUS_ACCOUNT_NONEXIST {
                    self.showErrorAlert("Could not create Account", msg:"Problem creaing account.")
                }
                
            } else {
                //write if let on user to ensure its not empty
                if let userKey = NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) as? String {
                    if userKey == user!.uid {
                        NSUserDefaults.standardUserDefaults().setValue(self.emailtxtField.text, forKey:"email")
                        NSUserDefaults.standardUserDefaults().setValue(self.passwordtxtField.text, forKey: "password")
                        self.performSegueWithIdentifier("LogTimeline", sender: nil)
                    } else {
                        NSUserDefaults.standardUserDefaults().setValue(self.emailtxtField.text, forKey:"email")
                        NSUserDefaults.standardUserDefaults().setValue(self.passwordtxtField.text, forKey: "password")
                        NSUserDefaults.standardUserDefaults().setValue(user!.uid, forKey: KEY_UID)
                        let userData = ["provider":"email"]
                        DataService.ds.createFirebaseUser(user!.uid, user: userData)
                        self.performSegueWithIdentifier("ProfileVC", sender: nil)
                    }
                } else {
                    NSUserDefaults.standardUserDefaults().setValue(self.emailtxtField.text, forKey:"email")
                    NSUserDefaults.standardUserDefaults().setValue(self.passwordtxtField.text, forKey: "password")
                    NSUserDefaults.standardUserDefaults().setValue(user!.uid, forKey: KEY_UID)
                    let userData = ["provider":"email"]
                    DataService.ds.createFirebaseUser(user!.uid, user: userData)
                    self.performSegueWithIdentifier("ProfileVC", sender: nil)
                }
            }
            
        })
    }
    
    //MARK: Error message to User
    func showErrorAlert(title:String, msg:String) {
        let alert = UIAlertController(title: title , message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "ok", style:.Default, handler:nil)
        alert.addAction(action)
        presentViewController(alert, animated:true, completion: nil)
    }
    

}
