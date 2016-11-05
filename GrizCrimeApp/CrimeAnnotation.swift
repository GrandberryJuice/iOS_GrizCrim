//
//  CrimeAnnotation.swift
//  GrizCrimeApp
//
//  Created by KENNETH GRANDBERRY on 9/22/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import Foundation


//crimeArray go here

class CrimeAnnotation:NSObject,MKAnnotation {
    var coordinate = CLLocationCoordinate2D()
    var crimeName:String
    var title: String?
    
    init(coordinate:CLLocationCoordinate2D, crimeName:String) {
        self.coordinate = coordinate
        self.crimeName = crimeName
        self.title = self.crimeName
    }
}