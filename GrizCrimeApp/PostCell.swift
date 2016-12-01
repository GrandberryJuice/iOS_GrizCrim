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
        ContentView.backgroundColor = UIColor.clear
    }
    

    
    //UIImage?
    //MARK: Setup posts and images for tableView Cell
    func configureCell(propicCrazy:UIImage?,img:UIImage?, post:Post) {
        self.post = post
        self.descriptionText.text = post.postDescription
        
        
        if post.imageUrl != nil {
            if img != nil {
                self.postImage.isHidden = false
                postImage.image = img
                return
                
            } else {
                if let imageUrl = post.imageUrl {
                    let url = URL(string:imageUrl)
                    if let imgUrl = url {
                        URLSession.shared.dataTask(with: imgUrl, completionHandler: { (data, response, error) in
                            if error != nil {
                                print("error")
                            } else {
                                if let imgData = data {
                                    if let downloadimg = UIImage(data: imgData) {
                                        TimeLineVC.imageCache.setObject(downloadimg, forKey:imageUrl as AnyObject)
                                        DispatchQueue.main.async(execute: {
                                            self.postImage.image = downloadimg
                                            self.postImage.isHidden = false
                                        })
                                    }
                                }
                            }
                            
                        }).resume()
                    }
                }
            }
        } else {
            self.postImage.isHidden = true
        }
    }
    

    //MARK: configure profile picture
    func configureProfileImages(propicCrazy:UIImage?, post:Post) {
        if post.profilePic != nil {
            if propicCrazy != nil {
                
                self.profileImage.isHidden = false
                profileImage.image = propicCrazy
                return
                
            } else {
                if let imageprofile = post.profilePic {
                    let profileimgurl = URL(string:imageprofile)
                    if let proimgUrl = profileimgurl {
                        URLSession.shared.dataTask(with: proimgUrl, completionHandler: { (data, response, error) in
                            if error != nil {
                                print("error")
                            } else {
                                print("downloading image")
                                if let testData = data {
                                    if let downloading = UIImage(data: testData) {
                                        TimeLineVC.imageCache.setObject(downloading, forKey:imageprofile  as NSString)
                                        DispatchQueue.main.async(execute: {
                                            print("still downloaded image")
                                            self.profileImage.image = downloading
                                            self.profileImage.isHidden = false
                                            
                                        })
                                    }
                                }
                            }
                        }).resume()
                    }
                }
            }
        } else {
            self.profileImage.isHidden = true
        }
    }
    
    //MARK Draw Circles around images
    override func draw(_ rect: CGRect) {
        profileImage.circleImage(profileImage)
        profileImage.clipsToBounds = true
    }
    
}
