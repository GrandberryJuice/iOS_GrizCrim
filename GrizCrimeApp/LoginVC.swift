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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func fbBtnPressed(sender:UIButton!) {
        //let ref = URL_BASE
        let facebookLogin = FBSDKLoginManager()
       
    
       facebookLogin.logInWithReadPermissions(["email"], fromViewController: self) { facebookResult, facebookError in
            if facebookError != nil {
            //If there is a facebook login error handle here!!
                print("Login with facebook error \(facebookError)")
                
                
            } else if facebookResult.isCancelled {
                //if facebook login was cancelled handle here!!
             
                
                
            } else {
                //User was able to login
//              let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
//                
//                let credentials = FIRFacebookAuthProvider.credentialWithAccessToken(accessToken)
                
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                let credentials = FIRFacebookAuthProvider.credentialWithAccessToken(accessToken)
                
                FIRAuth.auth()?.signInWithCredential(credentials, completion: { (user, error) in
                    if error != nil {
                        print("Login failed. \(error)")
                    } else {
                        
                        let userData = ["provider" : credentials.provider]
                        DataService.ds.createFirebaseUser(user!.uid, user: userData)
                        NSUserDefaults.standardUserDefaults().setValue(user!.uid, forKey: KEY_UID)
                        self.performSegueWithIdentifier("TimelineVC", sender: nil)
                        print("working")
                    }
                })
            }
        }
    }

}
