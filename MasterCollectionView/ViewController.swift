//
//  ViewController.swift
//  MasterCollectionView
//
//  Created by DAIXinming on 22/02/2017.
//  Copyright © 2017 Xinming DAI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myCollectionView.reloadItems(at: [IndexPath()])
    }
}

