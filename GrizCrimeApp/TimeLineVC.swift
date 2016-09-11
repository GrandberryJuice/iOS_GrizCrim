//
//  TimeLineVC.swift
//  GrizCrimeApp
//
//  Created by KENNETH GRANDBERRY on 6/30/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
// TableView functionality is in TableView extension


import UIKit
import Firebase


class TimeLineVC: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var TableView:UITableView!
    var posts = [Post]()
    static var imageCache:NSCache = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        TableView.estimatedRowHeight = 335
        
        //MARK: Firebase Data Retrieve
        DataService.ds.Ref_Post.observeEventType(.Value, withBlock:  { snapshot in
            self.posts = []
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshots {
                    //value is all data inside the key
                    //print(snap)
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, dictionary: postDict)
                        self.posts.append(post)
                    }
                }
            }
            //print(self.posts[2].imageUrl)
            self.TableView.reloadData()
        })
    }
}
