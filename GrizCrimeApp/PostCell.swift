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
    
    //MARK: Outlets and Variables
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
    
    
    //UIImage?
    //MARK: Setup posts and images for tableView Cell
    func configureCell(img:UIImage?, post:Post) {
        self.post = post
        self.descriptionText.text = post.postDescription
        
        if post.imageUrl != nil {
            if img != nil {
                 self.postImage.hidden = false
                print("imaged Cached:  \(img)")
                postImage.image = img
                return
                
            } else {
                if let imageUrl = post.imageUrl {
            
                    let url = NSURL(string:imageUrl)
                    if let imgUrl = url {
                        NSURLSession.sharedSession().dataTaskWithURL(imgUrl, completionHandler: { (data, response, error) in
                            if error != nil {
                                print("error")
                            } else {
                                if let imgData = data {
                                    if let downloadimg = UIImage(data: imgData) {
                                        TimeLineVC.imageCache.setObject(downloadimg, forKey:imageUrl)
                                        dispatch_async(dispatch_get_main_queue(), {
                                            self.postImage.image = downloadimg
                                            self.postImage.hidden = false
                                        })
                                    }
                                }
                            }
                            
                        }).resume()
                    
                    }
                }
            }
        } else {
            self.postImage.hidden = true
        }
    }
    
    func configureCellProfile(username:String,imgProfile:String ) {
        self.username.text = username
        
        let ref = FIRStorage.storage().referenceForURL(imgProfile)
        ref.dataWithMaxSize(2*1024*1024, completion: { (data, error) in
            if error != nil {
                print("There was an error with image download")
            } else {
                print("There images where downloaded")
                
                if let postImg = data {
                    if let img = UIImage(data:postImg) {
                        self.postImage.image = img
                       
                        TimeLineVC.imageCache.setObject(img, forKey:imgProfile )
                    }
                }
            }
        })
        
        
    }
    
    //MARK Draw Circles around images
    override func drawRect(rect: CGRect) {
        profileImage.circleImage(profileImage)
        profileImage.clipsToBounds = true
    }
    
}
