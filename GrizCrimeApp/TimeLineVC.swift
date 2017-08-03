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
    @IBOutlet weak var menuview: UIView!
    
    let listArray = ["Map","About","Close"]
    let menu = ["menuMap-1.png","menuAbout-1.png", "menuClose-1.png"]
    let buttonWasClicked = false
    var posts = [Post]()
    var profilePost = [PostProfile]()
    
    static var imageCache = NSCache<AnyObject, AnyObject>()
    static var profileimageCache = NSCache<NSString,UIImage>()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
       
        TableView.delegate = self
        TableView.dataSource = self
        
        menuTableView.reloadData()
        self.menuTableView.reloadData()
        TableView.estimatedRowHeight = 335
        
    
        menuview.layer.cornerRadius = 5.0
       
        //MARK: Firebase Data Retrieve
        DataService.ds.Ref_Post.queryLimited(toLast: 500).observe(.value, with:  { snapshot in
            self.posts = []
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshots {
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, dictionary: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.posts.reverse()
            self.TableView.reloadData()
        })
        self.menuConstraints.constant = -400
    }
    
    
    //MARK: Animate menu view
    @IBAction func PressedMenuBtn(_ sender: UIButton) {
        menuTableView.reloadData()
        darkbackground.isHidden = false
        darkbackground.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.menuTableView.reloadData()
            self.menuConstraints.constant = 0
            //self.tableViewMenuConstraints.constant = 0
            self.view.layoutIfNeeded()
        }) 
    }
   
    
    @IBAction func PressedPostBtn(_sender:UIButton) {
        self.performSegue(withIdentifier: "PostVC", sender: nil)
        
    }
    
    
    //MARK: Dismiss menu
    func handleDismiss() {
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.darkbackground.isHidden = true
            self.menuConstraints.constant = -400
        }) 
    }
    
    
    @IBAction func buttonTapped(_ sender:AnyObject) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:TableView)
        let indexPath = TableView.indexPathForRow(at: buttonPosition)
    
        let reportPost = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let reportAction = UIAlertAction(title: "Report this Post", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
          
            self.deletePost(tag:(indexPath?.row)!)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        reportPost.addAction(reportAction)
        reportPost.addAction(cancelAction)
        self.present(reportPost, animated: true, completion: nil)
    }
    
    
    func deletePost(tag:Int) {
        let post = self.posts[tag]
        DataService.ds.Ref_Post.child(post.postKey).removeValue()
    }
    
    @IBAction func unwindToTimeLineVC(undwindSegue:UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailPostVC" {
            if let detailPostVC = segue.destination as? DetailPostVC {
                if let data = sender as? [Any] {
                    detailPostVC.name = data[0] as? String
                    detailPostVC.post = data[3] as? String
                    detailPostVC.userPostImg = data[2] as? UIImage
                    detailPostVC.userPic = data[1] as? UIImage
                }
            }
        }
    }
}
