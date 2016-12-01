//
//  PostVC.swift
//  GrizCrimeApp
//
//  Created by KENNETH GRANDBERRY on 9/5/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import Firebase


class PostVC: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Outlets & variables
    @IBOutlet weak var textCountLbl: UILabel!
    @IBOutlet weak var textViewLbl: UITextView!
    @IBOutlet weak var uploadImg: UIImageView!
    var imagePicker:UIImagePickerController!
    
    typealias Block = () -> ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textCountLbl.text = "140"
        textViewLbl.delegate = self
        textViewLbl.text = "Whats Going on?"
        textViewLbl.textColor = UIColor.darkGray
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PostVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
       
    }
    
    //MARK: Remaining Characters
    func checkRemainingchars() {
        let allowedCharacters = 140
        let charInTextView = -textViewLbl.text.characters.count
        let remainingChar = allowedCharacters + charInTextView
        
        if remainingChar <= 20 {
            textCountLbl.textColor = UIColor.orange
        }
        
        if remainingChar <= 10 {
            textCountLbl.textColor = UIColor.red
        }
        
        textCountLbl.text = String(remainingChar)
    }
    
    //MARK: Text Changed
    func textViewDidChange(_ textView: UITextView) {
        checkRemainingchars()
    }
    
    //MARK: Back Btn Pressed
    @IBAction func BackBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {});
    }
    
    //MAK: Pressed Send Button
    @IBAction func SendBtnPressed(_ sender: UIButton) {
        let allowedCharacters = 140
        let charInTextView = -textViewLbl.text.characters.count
        let remainingChar = allowedCharacters + charInTextView
        
        if textViewLbl.text != "" {
            if remainingChar < 0 {
                let alert = UIAlertController(title:"Too many words in post", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            } else {
                let alert = UIAlertController(title:"Post was made ", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                if let img = uploadImg.image {
                    let upload = UIImageJPEGRepresentation(img, 0.2)
                    
                    PostToFirebase(upload)
                    dismiss(animated: true, completion: {})
                } else {
                    PostToFirebase(nil)
                }
                
            }
        }
        
    }
    
    //MARK: Pressed Camera Button
    @IBAction func CameraBtnPressed(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: Image Picker Controller
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismiss(animated: true, completion: nil)
        uploadImg.image = image
        
        
    }
    
    //MARK: 
    func getmain(_ block:@escaping Block) {
        let queue = DispatchQueue.main
        queue.async(execute: block)
    }
    
    //MARK: Post Data to Firebase
    func PostToFirebase(_ imgUrl:Data?) {
        
        var postDict:Dictionary<String,AnyObject> = [
            "description" : textViewLbl.text as AnyObject
        ]
        
        if let username = UserDefaults.standard.value(forKey: "username") as? String {
            postDict["username"] = username as AnyObject?
        }
        
        if let profilePic = UserDefaults.standard.value(forKey: "profileImg") as? String {
            postDict["profilePic"]  = profilePic as AnyObject?
        }
        
        let firebasePost = DataService.ds.Ref_Post.childByAutoId()
        
        if (imgUrl != nil) {
            
            let imgUid = UUID().uuidString
            DataService.ds.Ref_Post_Images.child(imgUid)
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/jpeg"
            
            DataService.ds.Ref_Post_Images.child(imgUid).put(imgUrl!, metadata: metaData) {
                (metaData,error) in
                
                if error != nil {
                    print("Error with uploading img")
                } else {
                    print("Successfully post image")
                    let downloadUrl = metaData?.downloadURL()?.absoluteString
                    postDict["imageUrl"] = downloadUrl as AnyObject?
                    
                    firebasePost.setValue(postDict)
                    self.uploadImg = nil
                    self.dismiss(animated: true, completion: {})
                }
            }
            
        } else {
            firebasePost.setValue(postDict)
            self.dismiss(animated: true, completion: {})
        }
    }
    
    func dismissKeyboard() {
        //Close keyboard
        view.endEditing(true)
    }
    
}
