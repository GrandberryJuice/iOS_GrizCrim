//
//  CrimeCell.swift
//  GrizCrimeApp
//
//  Created by KENNETH GRANDBERRY on 9/24/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit

class CrimeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg:UIImageView!
    @IBOutlet weak var thumbLabel:UILabel!
    
//    var crimeVC:CrimeCollectionView!
    
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(crimeName:String,crimeImage:String) {
//        self.crimeVC = crime
        
        thumbImg.image = UIImage(named:crimeImage)
        thumbLabel.text = crimeName
    }
}
