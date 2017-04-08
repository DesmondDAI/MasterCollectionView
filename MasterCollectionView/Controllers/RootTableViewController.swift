//
//  RootTableViewController.swift
//  MasterCollectionView
//
//  Created by DAIXinming on 22/03/2017.
//  Copyright © 2017 Xinming DAI. All rights reserved.
//

import UIKit

class RootTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
//         self.clearsSelectionOnViewWillAppear = false
        
        configNavigationBar()
        self.tableView.tableFooterView = UIView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
  
    
    // MARK: - Internal Methods
    private func configNavigationBar() {
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
    }
}

extension RootTableViewController {
    
    // MARK: UITableViewDelegate, UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "UIScrollView上下拖动改变可位置"
            
        case 1:
            cell.textLabel?.text = "UITableView的分页功能"
            
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "RootPushToMovableScrollView", sender: self)
            
        case 1:
            performSegue(withIdentifier: "RootPushToPaingTableVC", sender: self)
            
        default:
            break
        }
    }
}
