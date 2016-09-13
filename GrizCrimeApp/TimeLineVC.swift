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
    @IBOutlet weak var menuConstraints: NSLayoutConstraint!
    @IBOutlet weak var darkbackground: UIView!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var tableViewMenuConstraints: NSLayoutConstraint!
    
    let menuArray = ["Profile","Map","About","Close"]
    let menuIcons = ["profilemenu.png","menuMap.png","menuAbout.png", "menuClose.png"]
    
    
    
    var posts = [Post]()
    static var imageCache:NSCache = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.delegate = self
        TableView.dataSource = self
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.reloadData()
        
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
           
            self.TableView.reloadData()
        })
        self.menuConstraints.constant = -300
    }
    
    
    //MARK: Animate menu view
    @IBAction func PressedMenuBtn(sender: UIButton) {
        menuTableView.reloadData()
        darkbackground.hidden = false
        darkbackground.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
        UIView.animateWithDuration(0.5) { () -> Void in
            self.menuConstraints.constant = 0
            //self.tableViewMenuConstraints.constant = 0
            
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: Dismiss menu
    func handleDismiss() {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.darkbackground.hidden = true
            self.menuConstraints.constant = -300
           
        }
    }
    
}
