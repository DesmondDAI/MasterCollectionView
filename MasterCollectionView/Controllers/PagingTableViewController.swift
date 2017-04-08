//
//  PagingTableViewController.swift
//  MasterCollectionView
//
//  Created by DAIXinming on 08/04/2017.
//  Copyright © 2017 Xinming DAI. All rights reserved.
//

import UIKit

class PagingTableViewController: UIViewController {

    @IBOutlet weak var pagingTableView: UITableView!
    
    let miniOffsetBeyondBound: CGFloat = 64
    var textDataArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        self.navigationController?.navigationBar.tintColor = .white
        DataManager.sharedInstance.clearData()
        requestTextData()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // MARK: - Internal Methods
    private func setupTableView() {
        pagingTableView.delegate = self
        pagingTableView.dataSource = self
        pagingTableView.estimatedRowHeight = 60
        pagingTableView.rowHeight = UITableViewAutomaticDimension
        pagingTableView.tableFooterView = UIView()
    }
    
    func requestTextData() {
        let newDataArray = DataManager.sharedInstance.generateTextArray(count: 20)
        textDataArray.append(contentsOf: newDataArray)
        pagingTableView.reloadData()
    }
}


extension PagingTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PagingTableViewCell", for: indexPath)
        cell.textLabel?.text = textDataArray[indexPath.row]
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let pagingThreshold = scrollView.contentSize.height - UIScreen.main.bounds.height + miniOffsetBeyondBound
        if offsetY > pagingThreshold && !scrollView.isDragging {  // Scroll beyond specific offset & release dragging
            self.requestTextData()
        }
    }
}
