//
//  PostProfile.swift
//  GrizCrimeApp
//
//  Created by KENNETH GRANDBERRY on 9/28/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import Foundation

class PostProfile {
    fileprivate var _profileImage:String!
    fileprivate var _username:String!
    
    var profileImage:String {
        return _profileImage
    }
    
    var username:String {
        return _username
    }
    
    
    init(dictionary:Dictionary<String,AnyObject>) {
        
        if let username = dictionary["username"] as? String {
            self._username = username
        }
        
        if let profileImage = dictionary["profileImage"] as? String {
            self._profileImage = profileImage
        }
        
    }

}

