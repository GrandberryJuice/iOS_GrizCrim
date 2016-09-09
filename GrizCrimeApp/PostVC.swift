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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textCountLbl.text = "140"
        textViewLbl.delegate = self
        textViewLbl.text = "Whats Going on?"
        textViewLbl.textColor = UIColor.darkGrayColor()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
       
    }
    
    //MARK: Remaining Characters
    func checkRemainingchars() {
        let allowedCharacters = 140
        let charInTextView = -textViewLbl.text.characters.count
        let remainingChar = allowedCharacters + charInTextView
        
        if remainingChar <= 20 {
            textCountLbl.textColor = UIColor.orangeColor()
        }
        
        if remainingChar <= 10 {
            textCountLbl.textColor = UIColor.redColor()
        }
        
        textCountLbl.text = String(remainingChar)
    }
    
    //MARK: Text Changed
    func textViewDidChange(textView: UITextView) {
        checkRemainingchars()
    }
    
    //MARK: Back Btn Pressed
    @IBAction func BackBtnPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    //MAK: Pressed Send Button
    @IBAction func SendBtnPressed(sender: UIButton) {
        let allowedCharacters = 140
        let charInTextView = -textViewLbl.text.characters.count
        let remainingChar = allowedCharacters + charInTextView
        
        if textViewLbl.text != "" {
            if remainingChar < 0 {
                let alert = UIAlertController(title:"Too many words in post", message: nil, preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title:"OK", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
            } else {
                let alert = UIAlertController(title:"Post was made ", message: nil, preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title:"OK", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
                if let img = uploadImg.image {
                    let upload = UIImagePNGRepresentation(img)
                   PostToFirebase(upload)
                    
                }
                
            }
        }
        
    }
    
    //MARK: Pressed Camera Button
    @IBAction func CameraBtnPressed(sender: UIButton) {
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: Image Picker Controller
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        uploadImg.image = image
        
        
    }
    
    
    func PostToFirebase(imgUrl:NSData?) {
        
        var postDict:Dictionary<String,AnyObject> = [
            "description" : textViewLbl.text
        ]
        
        let storage = FIRStorage.storage()
        let storageRef = storage.reference()
        
        
    }
}