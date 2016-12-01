//
//  MenuCell.swift
//  GrizCrimeApp
//
//  Created by KENNETH GRANDBERRY on 9/11/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var titleLbl:UILabel!
    @IBOutlet weak var titleIconImg:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(_ title:String, icon:String) {
        titleLbl.text = title
        titleIconImg.image = UIImage(named:icon)
    }
    
    
}
