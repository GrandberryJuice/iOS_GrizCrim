//
//  CrimeCollectionView.swift
//  GrizCrimeApp
//
//  Created by KENNETH GRANDBERRY on 9/24/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit


class CrimeCollectionView {
    fileprivate var _name:String!
    fileprivate var _image:String!
    
    var name:String {
        return _name
    }
    
    
    var image:String {
        return _image
    }


    init(crimeName:String, crimeImage:String) {
        self._name = crimeName
        self._image = crimeImage
    }
}
