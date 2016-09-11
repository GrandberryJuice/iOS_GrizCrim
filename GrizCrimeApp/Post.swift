//
//  Post.swift
//  GrizCrimeApp
//
//  Created by KENNETH GRANDBERRY on 7/8/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import Foundation

class Post {
    
    private var _postDescription:String!
    private var _imageUrl:String?
    private var _username:String!
    private var _postKey:String!
    
    var postDescription:String {
        return _postDescription
    }
    
    var imageUrl:String? {
        return _imageUrl
    }
    
    var username:String {
        return _username
    }
    
    
    var postKey:String {
        return _postKey
    }
    
    init(description:String, imageUrl:String?, username:String) {
        self._postDescription = description
        self._imageUrl = imageUrl
        self._username = username
    }
    
    //parsing downloading data
    init(postKey:String, dictionary:Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let imgUrl = dictionary["imageUrl"] as? String {
            self._imageUrl = imgUrl
        }
        
        if let desc = dictionary["description"] as? String {
            self._postDescription = desc
        }
        
        //add username later on!!
        
    }
}