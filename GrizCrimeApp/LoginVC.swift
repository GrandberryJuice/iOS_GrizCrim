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


class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func fbBtnPressed(sender:UIButton!) {
        let ref = URL_BASE
        let facebookLogin = FBSDKLoginManager()
    
        facebookLogin.logInWithReadPermissions(["email"], handler: {(facebookResult, facebookError) -> Void in
            if facebookError != nil {
            //If there is a facebook login error handle here!!
                print("Login with facebook error \(facebookError)")
                
                
            } else if facebookResult.isCancelled {
                //if facebook login was cancelled handle here!!
                
                
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("Successfully logged in with facebook. \(accessToken)")
//                ref.authWithOAuthProvider("facebook", token: accessToken,
//                    withCompletionBlock: { error, authData in
//                        if error != nil {
//                            println("Login failed. \(error)")
//                        } else {
//                            println("Logged in! \(authData)")
//                        }
//                })
            }
        })
    }

}
