//
//  PostCell.swift
//  GrizCrimeApp
//
//  Created by KENNETH GRANDBERRY on 6/30/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import Alamofire

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
                //fetch request
                request = Alamofire.request(.GET, post.imageUrl!).validate(contentType:["image/*"]).response(completionHandler: {
                    request, response, data,  err in
                    
                    if err == nil {
                        let img = UIImage(data:data!)!
                        self.postImage.image = img
                        TimeLineVC.imageCache.setObject(img, forKey: self.post.imageUrl!)
                    }
                })
                
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
