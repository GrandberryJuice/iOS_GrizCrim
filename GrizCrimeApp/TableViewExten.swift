//
//  TableViewExten.swift
//  GrizCrimeApp
//
//  Created by KENNETH GRANDBERRY on 6/30/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import Foundation

extension TimeLineVC : UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        if tableView == self.TableView {
            
            let post = posts[indexPath.row]
            if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCell {
                cell.request?.cancel()
                var img:UIImage?
                
                if let url = post.imageUrl {
                    img = TimeLineVC.imageCache.objectForKey(url) as? UIImage
                }
                
                cell.configureCell(img, post: post)
                return cell
            } else {
                return PostCell()
            }
        } else {
        
            let menuTitle = listArray[indexPath.row]
            let icon = menu[indexPath.row]
            
            if let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell") as? MenuCell {
                cell.configureCell(menuTitle, icon: icon)
                return cell
            } else {
                let cell = MenuCell()
                cell.configureCell(menuTitle, icon: icon)
                return cell
            }
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.TableView{
            return posts.count
        } else {
        return self.listArray.count
        }
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        if tableView == self.TableView {
//            let post = posts[indexPath.row]
//            if post.imageUrl == nil {
//                return 200
//            } else {
//                return TableView.estimatedRowHeight
//            }
//        }
//        return menuTableView.estimatedRowHeight
//    }
    
}