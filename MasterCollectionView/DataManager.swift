//
//  DataManager.swift
//  MasterCollectionView
//
//  Created by DAIXinming on 08/04/2017.
//  Copyright © 2017 Xinming DAI. All rights reserved.
//

import Foundation

class DataManager {
    
    static let sharedInstance: DataManager = {
        return DataManager.init()
    }()
    
    var itemsOffset: Int = 0
    
    func clearData() {
        itemsOffset = 0
    }
    
    func generateTextArray(count: Int) -> [String] {
        var textArray = [String]()
        let start = itemsOffset + 1
        let end = itemsOffset + count
        for index in start...end {
            textArray.append("text item - \(index)")
        }
        itemsOffset = end
        
        return textArray
    }
}
