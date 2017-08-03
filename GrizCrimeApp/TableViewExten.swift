//
//  TableViewExten.swift
//  GrizCrimeApp
//
//  Created by KENNETH GRANDBERRY on 6/30/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import Foundation

extension TimeLineVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if tableView == self.TableView {
            
            let post = posts[indexPath.row]
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
                
                cell.request?.cancel()
                
                var img: UIImage?
                var profilePicture:UIImage?
                
                //post pictures
                if let url = post.imageUrl {
                    img = TimeLineVC.imageCache.object(forKey: url as AnyObject) as? UIImage
                   
                }
                
                //profile picture
                if let propic = post.profilePic {
                    profilePicture = TimeLineVC.imageCache.object(forKey: propic as AnyObject) as? UIImage
                }
                
                cell.configureCell(propicCrazy: profilePicture, img: img, post: post)
                cell.configureProfileImages(propicCrazy: profilePicture, post: post)
                return cell
                
            } else {
                return PostCell()
            }
        } else {
        
            let menuTitle = listArray[indexPath.row]
            let icon = menu[indexPath.row]
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as? MenuCell {
                cell.configureCell(menuTitle, icon: icon)
                return cell
            } else {
                let cell = MenuCell()
                cell.configureCell(menuTitle, icon: icon)
                return cell
            }
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.TableView{
            return posts.count
        } else {
            return self.listArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.TableView {
            let post = posts[indexPath.row]
            if post.imageUrl == nil {
                return 250
            } else {
                return TableView.estimatedRowHeight
            
            }
        } else {
            return 52
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if tableView == self.menuTableView {
            let menuTitle = listArray[indexPath.row]
            //Operate menu
            if menuTitle == "Map" {
                performSegue(withIdentifier: "MapVC", sender: nil)
                handleDismiss()
            } else if menuTitle == "Profile" {
                performSegue(withIdentifier: "ProfileVC", sender: nil)
                handleDismiss()
            } else  if menuTitle == "About" {
                performSegue(withIdentifier: "AboutUsVC", sender: nil)
                handleDismiss()
            } else if menuTitle == "Close"{
                UIView.animate(withDuration: 0.5, animations: { () -> Void in
                    self.darkbackground.isHidden = true
                    self.menuConstraints.constant = -300
                })
            }
        } else if tableView == self.TableView {
            let data = posts[indexPath.row]
            
            if let cell = tableView.cellForRow(at: indexPath) as? PostCell {
               
                let name = cell.username.text
                let propic = cell.profileImage.image
                let postImg = cell.postImage.image
                let userpost = cell.descriptionText.text
                
                let dataArray = [name, propic ,postImg, userpost] as [Any]
            
                 performSegue(withIdentifier: "DetailPostVC", sender: dataArray)
            }
            
        }
        
    }
    
}
