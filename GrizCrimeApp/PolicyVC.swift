//
//  PolicyVC.swift
//  GrizCrimeApp
//
//  Created by KENNETH GRANDBERRY on 12/9/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit

class PolicyVC: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.scrollView.frame = self.view.bounds
        self.scrollView.contentSize.height = 3000
    }
    
    @IBAction func GoBack(_ sender: Any) {
         dismiss(animated: true, completion: {})
    }
}
