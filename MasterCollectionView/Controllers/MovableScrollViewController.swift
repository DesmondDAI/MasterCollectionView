//
//  MovableScrollViewController.swift
//  MasterCollectionView
//
//  Created by DAIXinming on 22/03/2017.
//  Copyright © 2017 Xinming DAI. All rights reserved.
//

import UIKit

class MovableScrollViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var panBeginLocation: CGPoint = CGPoint(x: 0, y: 0)
    let defaultScrollViewInset: UIEdgeInsets = UIEdgeInsetsMake(100, 0, 0, 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScrollView()
    }


    // MARK: Internal Methods
    private func setupScrollView() {
        scrollView.delegate = self
        // Add images
        addImageViewsToScrollView(number: 5)
        
        scrollView.contentInset = defaultScrollViewInset
        scrollView.contentOffset = CGPoint(x: 0, y: -defaultScrollViewInset.top)
        scrollView.scrollIndicatorInsets = defaultScrollViewInset
    }
    
    private func addImageViewsToScrollView(number: Int) {
        guard let image: UIImage = UIImage(named: "shiba_1") else { return }
        let imageAspectRatio: CGFloat = image.size.height / image.size.width  // w / h
        let pageWidth: CGFloat = UIScreen.main.bounds.width
        let pageHeight: CGFloat = pageWidth * imageAspectRatio
        
        // Setup scroll view content size
        scrollView.contentSize = CGSize(width: pageWidth, height: CGFloat(number) * pageHeight)
        
        for index in 0..<number {
            let imageView: UIImageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0, y: CGFloat(index) * pageHeight, width: pageWidth, height: pageHeight)
            imageView.contentMode = .scaleAspectFill
            scrollView.addSubview(imageView)
        }
    }
}


extension MovableScrollViewController: UIScrollViewDelegate {
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY: CGFloat = scrollView.contentOffset.y
        print("offset Y: \(contentOffsetY)")
      
        if contentOffsetY > 0 {  // Remove inset in order to align indicator to the top
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
        else {  // Add back inset and adjust indicator inset according to content offset
            scrollView.contentInset = defaultScrollViewInset
            scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(abs(contentOffsetY), 0, 0, 0)
        }
    }
}
