//
//  ProfileVC.swift
//  GrizCrimeApp
//
//  Created by KENNETH GRANDBERRY on 9/5/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import Firebase

class ProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var uploadImage:UIImageView!
    @IBOutlet weak var username: UITextField!
    var imagePicker:UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
 

    @IBAction func selectProfilePic(sender: AnyObject) {
         presentViewController(imagePicker, animated: true, completion: nil)
    }

    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        uploadImage.image = image
    }
    
    
    @IBAction func PressedContinue(sender:UIButton) {
        if uploadImage.image != nil && username.text != nil {
            if let img = uploadImage.image {
                let upload = UIImageJPEGRepresentation(img, 0.2)
                PostToFirebase(upload!)
            }
        }
    }
    
    func PostToFirebase(imgUrl:NSData) {
        var postDict:Dictionary<String,AnyObject> = [
            "username": username.text!
        ]
        
        
        let imgUid = NSUUID().UUIDString
        DataService.ds.Ref_Profile_Images.child(imgUid)
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpeg"
        
        DataService.ds.Ref_Profile_Images.child(imgUid).putData(imgUrl, metadata:metaData) { (metaData, error) in
            
            if error != nil {
                print("Error with uploading Profile img")
            } else {
                print("Successfully posted image")
                let downloadUrl = metaData?.downloadURL()?.absoluteString
                postDict["profilePic"] = downloadUrl
               
               NSUserDefaults.standardUserDefaults().setValue(downloadUrl, forKey:"profileImg")
               NSUserDefaults.standardUserDefaults().setValue(self.username.text, forKey:"username")
                
               let userid = NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) as? String
                DataService.ds.createFirebaseUserProfile(userid!, user: postDict)
            }
            
        }
    }
    
    func dismissKeyboard() {
        //Close keyboard
        view.endEditing(true)
    }
    
}
