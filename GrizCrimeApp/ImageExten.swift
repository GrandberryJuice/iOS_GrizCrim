//
//  ImageExten.swift
//  GrizCrimeApp
//
//  Created by KENNETH GRANDBERRY on 6/30/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import Foundation

extension UIImageView {
    
    func circleImage (_ image:UIImageView) {
        image.layer.cornerRadius = image.frame.size.width / 2
    }
}
