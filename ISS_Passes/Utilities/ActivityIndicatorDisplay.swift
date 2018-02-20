//
//  ActivityIndicatorDisplay.swift
//  ISS_Passes
//
//  Created by Carter Lowery on 2/20/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Foundation
import UIKit

class ActivityIndicatorDisplay {
    
    static let sharedInstance = ActivityIndicatorDisplay()
    
    private var container: UIView
    private var loadingView: UIView
    private var activityIndicator: UIActivityIndicatorView
    
    init() {
        // identify app name and version
        self.container = UIView()
        self.loadingView = UIView()
        self.activityIndicator = UIActivityIndicatorView()
    }
    
    /** Displays an activity indicator
        - parameter uiView:  The view to add the activity indicator to.
    */
    func showActivityIndicatory(uiView: UIView) {
        self.container = UIView(frame: uiView.frame)
        self.container.center = uiView.center
        self.container.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        self.loadingView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        self.loadingView.center = uiView.center
        self.loadingView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        self.loadingView.clipsToBounds = true
        self.loadingView.layer.cornerRadius = 10
        
        self.activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0))
        self.activityIndicator.activityIndicatorViewStyle = .whiteLarge
        self.activityIndicator.center = CGPoint(x: self.loadingView.frame.size.width / 2, y: self.loadingView.frame.size.height / 2)
        self.loadingView.addSubview(self.activityIndicator)
        self.container.addSubview(self.loadingView)
        uiView.addSubview(self.container)
        self.activityIndicator.startAnimating()
    }
    
    /** Stops the activity indicator and removes it from the view
     */
    func hideActivityIndicatory() {
        self.activityIndicator.stopAnimating()
        self.container.removeFromSuperview()
    }
}
