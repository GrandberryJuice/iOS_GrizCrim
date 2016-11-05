//
//  CollectionViewCrimeExten.swift
//  GrizCrimeApp
//
//  Created by KENNETH GRANDBERRY on 9/24/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import Foundation


extension MapVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let name = crimeNames[indexPath.row]
        let img = crimeImages[indexPath.row]
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CrimeCell", forIndexPath: indexPath) as? CrimeCell {
            
            cell.configureCell(name,crimeImage:img)
            return cell
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let img = crimeNames[indexPath.row]
        let loc = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        createSighting(forLocation: loc, withCrimeType:img)
        
        UIView.animateWithDuration(0.5) { () -> Void in
            self.darkbackground.hidden = true
            self.collectionView.hidden = true
        }
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
}