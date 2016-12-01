//
//  CollectionViewCrimeExten.swift
//  GrizCrimeApp
//
//  Created by KENNETH GRANDBERRY on 9/24/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import Foundation


extension MapVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let name = crimeNames[indexPath.row]
        let img = crimeImages[indexPath.row]
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CrimeCell", for: indexPath) as? CrimeCell {
            
            cell.configureCell(name,crimeImage:img)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let img = crimeNames[indexPath.row]
        let loc = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        createSighting(forLocation: loc, withCrimeType:img)
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.darkbackground.isHidden = true
            self.collectionView.isHidden = true
        }) 
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
}
