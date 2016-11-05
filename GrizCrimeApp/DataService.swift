//
//  DataService.swift
//  GrizCrimeApp
//
//  Created by KENNETH GRANDBERRY on 6/6/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import Foundation
import Firebase


let URL_BASE =  FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()


//MARK: Firebase Services
class DataService {
    
    static let ds = DataService()
    //DB reference
    private var _Ref_Base = URL_BASE
    private var _Ref_Post = URL_BASE.child("post")
    private var _Ref_Users = URL_BASE.child("users")
    private var _Ref_Post_Images = STORAGE_BASE.child("post-images")
    private var _Ref_Profile_Images = STORAGE_BASE.child("profile-images")
    
    
    var Ref_Base:FIRDatabaseReference {
        return _Ref_Base
    }
    
    var Ref_Post:FIRDatabaseReference {
        return _Ref_Post
    }
    
    var Ref_Users:FIRDatabaseReference {
        return _Ref_Users
    }
    
    
    var Ref_Post_Images:FIRStorageReference {
        return _Ref_Post_Images
    }
    
    var Ref_Profile_Images:FIRStorageReference {
        return _Ref_Profile_Images
    }
    
    var Ref_User_Current:FIRDatabaseReference {
       let uid = NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) as! String
        let user = URL_BASE.child("users").child(uid)
        return user
    }
    
    func createFirebaseUser(uid:String, user:Dictionary<String,String>) {
        Ref_Users.child(uid).updateChildValues(user)
    }

    func createFirebaseUserProfile(uid:String, user:Dictionary<String,AnyObject>) {
        Ref_Users.child(uid).updateChildValues(user)
    }

}