//
//  ProgressBar.swift
//  LinearProgressBar
//
//  Created by Firdavs Khaydarov on 09/03/18.
//  Copyright © 2018 Firdavs Khaydarov. All rights reserved.
//

import UIKit

@objc public extension UIViewController {
    @discardableResult
    func showProgressBar() -> UIView {
        return ProgressBar.showProgressBar(self.view)
    }
    
    func hideProgressBar() {
        ProgressBar.removeAllProgressBars(self.view)
    }
}

open class ProgressBar: NSObject {
    // Some random number
    static let progressBarViewTag = 39074685
    
    open class Layout {
        public static func toTop(_ view: UIView) {
            assert(view.superview != nil, "`view` should have a superview")
            
            view.translatesAutoresizingMaskIntoConstraints = false
            
            let constraintT = NSLayoutConstraint(item: view,
                                                 attribute: NSLayoutConstraint.Attribute.top,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: view.superview,
                                                 attribute: NSLayoutConstraint.Attribute.top,
                                                 multiplier: 1,
                                                 constant: 0)
            let constraintL = NSLayoutConstraint(item: view,
                                                 attribute: NSLayoutConstraint.Attribute.left,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: view.superview,
                                                 attribute: NSLayoutConstraint.Attribute.left,
                                                 multiplier: 1,
                                                 constant: 0)
            let constraintR = NSLayoutConstraint(item: view,
                                                 attribute: NSLayoutConstraint.Attribute.right,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: view.superview,
                                                 attribute: NSLayoutConstraint.Attribute.right,
                                                 multiplier: 1,
                                                 constant: 0)
            
            view.superview!.addConstraints([constraintT, constraintL, constraintR])
        }
    }
    
    @discardableResult
    open class func showProgressBar(_ parentView: UIView) -> UIView {
        let progressBar = LinearProgressBar()
        progressBar.tag = progressBarViewTag
        
        parentView.addSubview(progressBar)
        
        Layout.toTop(progressBar)
        progressBar.startAnimating()
        
        return progressBar
    }
    
    open class func removeAllProgressBars(_ parentView: UIView) {
        parentView.subviews
            .filter { $0.tag == progressBarViewTag }
            .forEach { view in
                guard let view = view as? LinearProgressBar else { return }
                
                view.stopAnimating() {
                    view.removeFromSuperview()
                }
        }
    }
}
