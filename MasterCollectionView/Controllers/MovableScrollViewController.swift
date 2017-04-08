//
//  MovableScrollViewController.swift
//  MasterCollectionView
//
//  Created by DAIXinming on 22/03/2017.
//  Copyright © 2017 Xinming DAI. All rights reserved.
//

import UIKit

class MovableScrollViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var bgImageHeightConstraint: NSLayoutConstraint!
    
    let minScrollToHideShowStatusBar: CGFloat = 10
    static let defaultScrollViewOffsetY: CGFloat = 120
    
    var lastScrollOffsetY: CGFloat = -defaultScrollViewOffsetY
    var panBeginLocation: CGPoint = CGPoint(x: 0, y: 0)
    let defaultScrollViewInset: UIEdgeInsets = UIEdgeInsetsMake(defaultScrollViewOffsetY, 0, 0, 0)
    var isNavigationBarSetup: Bool = false
    var statusBarShouldHide = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScrollView()
        setupNavigationBar()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return statusBarShouldHide
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    

    // MARK: Internal Methods
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .white
    }
    
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
    
    // MARK: - Internal Methods
    private func animateTopBarHideShow() {
        UIView.animate(withDuration: 0.2, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: { (_) in
            self.navigationController?.setNavigationBarHidden(self.statusBarShouldHide, animated: true)
        })
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY: CGFloat = scrollView.contentOffset.y
        print("offset Y: \(contentOffsetY)")
        
        let scrollDiffY = contentOffsetY - self.lastScrollOffsetY
        if  abs(scrollDiffY) > minScrollToHideShowStatusBar {  // Scroll larger than the size that triggers status bar animation
            if contentOffsetY > -MovableScrollViewController.defaultScrollViewOffsetY && contentOffsetY < (scrollView.contentSize.height - UIScreen.main.bounds.height) {  // Forbit bouncing to affect staus bar show hide
                self.lastScrollOffsetY = contentOffsetY
                statusBarShouldHide = scrollDiffY > 0 ? true : false
                animateTopBarHideShow()
            }
        }
        
        if contentOffsetY > 0 {  // Remove inset in order to align indicator to the top
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
        else {  // Add back inset and adjust indicator inset according to content offset
            let bgImageHeight = contentOffsetY - 64
            bgImageHeightConstraint.constant = abs(bgImageHeight < 0 ? bgImageHeight : 0)
            scrollView.contentInset = defaultScrollViewInset
            scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(abs(contentOffsetY), 0, 0, 0)
        }
    }
}
