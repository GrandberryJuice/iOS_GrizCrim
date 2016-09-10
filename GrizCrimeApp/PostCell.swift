//
//  PostCell.swift
//  GrizCrimeApp
//
//  Created by KENNETH GRANDBERRY on 6/30/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImage:UIImageView!
    @IBOutlet weak var ContentView:UIView!
    @IBOutlet weak var descriptionText:UITextView!
    @IBOutlet weak var username:UILabel!
    @IBOutlet weak var postImage:UIImageView!
    
    var post:Post!
    //AlamoreFire request
    var request:Request?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ContentView.backgroundColor = UIColor.clearColor()
        
    }
    
    func configureCell(img:UIImage?, post:Post) {
        self.post = post
        self.descriptionText.text = post.postDescription
        
        if post.imageUrl != nil {
            if img != nil {
                self.postImage.image = img
            } else {
                if let imageUrl = post.imageUrl {
                 let ref = FIRStorage.storage().referenceForURL(imageUrl)
                    ref.dataWithMaxSize(2*1024*1024, completion: { (data, error) in
                        if error != nil {
                            print("There was an error with image download")
                        } else {
                            print("There images where downloaded")
                            
                            if let postImg = data {
                                if let img = UIImage(data:postImg) {
                                    self.postImage.image = img
                                     TimeLineVC.imageCache.setObject(img, forKey: post.imageUrl!)
                                }
                            }
                        }
                    })
                    
                }
            }
            
        } else {
            self.postImage.hidden = true
        }
        
    }
    
    override func drawRect(rect: CGRect) {
        profileImage.circleImage(profileImage)
        profileImage.clipsToBounds = true
    }
    
    
    
    
    
}
