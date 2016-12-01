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


class LoginVC: UIViewController, UITextFieldDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var emailtxtField:UITextField!
    @IBOutlet weak var passwordtxtField:UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailtxtField.attributedPlaceholder = NSAttributedString(string:"Email", attributes: [NSForegroundColorAttributeName:UIColor.white])
        passwordtxtField.attributedPlaceholder = NSAttributedString(string:"Password", attributes: [NSForegroundColorAttributeName:UIColor.white])
        
        emailtxtField.textColor = UIColor.white
        passwordtxtField.textColor = UIColor.white
        
        emailtxtField.delegate = self
        passwordtxtField.delegate = self

        if let email = UserDefaults.standard.value(forKey: "email") as? String,
            let password = UserDefaults.standard.value(forKey: "password") as? String {
            //check if user has a profile image and username
            if UserDefaults.standard.value(forKey: "profileImg") as? String != nil && UserDefaults.standard.value(forKey:"username") != nil {
                emailtxtField.text = email
                passwordtxtField.text = password
                login()
            } else {
                performSegue(withIdentifier: "ProfileVC", sender: nil)
            }
        }
    }
    
    
    //MARK: Email sign in
    @IBAction func Login_Signup(_ sender: AnyObject) {
        FIRAuth.auth()?.createUser(withEmail: emailtxtField.text!, password: passwordtxtField.text!, completion: {
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
        FIRAuth.auth()?.signIn(withEmail: emailtxtField.text!, password: passwordtxtField.text!, completion: {
        user, error in
            if error != nil {
                print(error)
                if error!._code == STATUS_ACCOUNT_NONEXIST {
                    self.showErrorAlert("Could not create Account", msg:"Problem creaing account.")
                }
                
            } else {
                //write if let on user to ensure its not empty
                if let userKey = UserDefaults.standard.value(forKey: KEY_UID) as? String {
                    if userKey == user!.uid {
                        UserDefaults.standard.setValue(self.emailtxtField.text, forKey:"email")
                        UserDefaults.standard.setValue(self.passwordtxtField.text, forKey: "password")
                        self.performSegue(withIdentifier: "LogTimeline", sender: nil)
                    } else {
                        UserDefaults.standard.setValue(self.emailtxtField.text, forKey:"email")
                        UserDefaults.standard.setValue(self.passwordtxtField.text, forKey: "password")
                        UserDefaults.standard.setValue(user!.uid, forKey: KEY_UID)
                        let userData = ["provider":"email"]
                        DataService.ds.createFirebaseUser(user!.uid, user: userData)
                        self.performSegue(withIdentifier: "ProfileVC", sender: nil)
                    }
                } else {
                    UserDefaults.standard.setValue(self.emailtxtField.text, forKey:"email")
                    UserDefaults.standard.setValue(self.passwordtxtField.text, forKey: "password")
                    UserDefaults.standard.setValue(user!.uid, forKey: KEY_UID)
                    let userData = ["provider":"email"]
                    DataService.ds.createFirebaseUser(user!.uid, user: userData)
                    self.performSegue(withIdentifier: "ProfileVC", sender: nil)
                }
            }
            
        })
    }
    
    //Move ScrollView for TextField
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0,y: 100), animated: true)
        scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDiss)))
    }
    
    //Close keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        return true
    }
    
    func handleDiss() {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        view.endEditing(true)
    }
    
    //MARK: Error message to User
    func showErrorAlert(_ title:String, msg:String) {
        let alert = UIAlertController(title: title , message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style:.default, handler:nil)
        alert.addAction(action)
        present(alert, animated:true, completion: nil)
    }
    

}
