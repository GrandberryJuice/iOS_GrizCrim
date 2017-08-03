//
//  DetailPostVC.swift
//  GrizCrimeApp
//
//  Created by KENNETH GRANDBERRY on 7/30/17.
//  Copyright © 2017 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit

class DetailPostVC: UIViewController {
    
    @IBOutlet weak var profilePic:UIImageView!
    @IBOutlet weak var postImg:UIImageView!
    @IBOutlet weak var userPost:UITextView!
    @IBOutlet weak var username:UILabel!
    
    var userPic:UIImage?
    var userPostImg:UIImage?
    var post:String?
    var name:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        userPost.text = post
        username.text = name
        profilePic.image = userPic
        postImg.image = userPostImg
        
        profilePic.circleImage(profilePic)
        profilePic.clipsToBounds = true
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {})
    }
    
}
