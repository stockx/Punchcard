//
//  UIView+AutoLayout.swift
//  Punchcard
//
//  Created by Josh Sklar on 2/1/17.
//  Copyright © 2017 StockX. All rights reserved.
//

import UIKit

extension UIView {

    // MARK: Edges

    /**
     Makes the edges of the receiver equal to the edges of `view`.
     
     Note: `view` must already be constrained, and both the receiver
     and `view` must have a common superview.
     */
    func makeEdgesEqualTo(_ view: UIView) {
        guard let sv = view.superview,
            sv == self.superview else {
                return
        }
        
        translatesAutoresizingMaskIntoConstraints = false

        [.top, .bottom, .leading, .trailing].forEach {
            sv.addConstraint(NSLayoutConstraint(item: self,
                                             attribute: $0,
                                             relatedBy: .equal,
                                             toItem: view,
                                             attribute: $0,
                                             multiplier: 1.0,
                                             constant: 0.0))
        }
    }
    
    /**
     Makes the edges of the receiver equal to its superview with an otion to
     specify an inset value.
     
     If the receiver does not have a superview, this does nothing.
     */
    func makeEdgesEqualToSuperview(inset: CGFloat = 0) {
        guard let superview = superview else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false

        let views = ["view": self]
        let metrics = ["inset": inset]

        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-inset-[view]-inset-|",
                                                      options: [],
                                                      metrics: metrics,
                                                      views: views))
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-inset-[view]-inset-|",
                                                      options: [],
                                                      metrics: metrics,
                                                      views: views))
    }
    
    // MARK: Attributes

    func makeAttributeEqualToSuperview(_ attribute: NSLayoutAttribute, offset: CGFloat = 0) {
        guard let superview = superview else {
            return
        }
        
        superview.addConstraint(NSLayoutConstraint(item: self,
                                                   attribute: attribute,
                                                   relatedBy: .equal,
                                                   toItem: superview,
                                                   attribute: attribute,
                                                   multiplier: 1.0,
                                                   constant: offset))
    }
    
    func makeAttribute(_ attribute: NSLayoutAttribute, equalTo constant: CGFloat) {
        guard let superview = superview else {
            return
        }
        
        superview.addConstraint(NSLayoutConstraint(item: self,
                                                   attribute: attribute,
                                                   relatedBy: .equal,
                                                   toItem: nil,
                                                   attribute: .notAnAttribute,
                                                   multiplier: 1.0,
                                                   constant: constant))
    }
    
    func makeAttribute(_ attribute: NSLayoutAttribute, equalToOtherView otherView: UIView, otherAttribute: NSLayoutAttribute, constant: CGFloat = 0) {
        guard let sv = otherView.superview,
            sv == self.superview else {
                return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        sv.addConstraint(NSLayoutConstraint(item: self,
                                            attribute: attribute,
                                            relatedBy: .equal,
                                            toItem: otherView,
                                            attribute: otherAttribute,
                                            multiplier: 1.0,
                                            constant: constant))
    }

    /**
     Removes all the constrains where the receiver is either the
     firstItem or secondItem.
     
     If the receiver does not have a superview, this only removes the
     constraints that the receiver owns.
     */
    func removeAllConstraints() {
        guard let superview = superview else {
            removeConstraints(constraints)
            return
        }
        
        for constraint in superview.constraints where (constraint.firstItem as? UIView == self || constraint.secondItem as? UIView == self) {
            superview.removeConstraint(constraint)
        }
        
        removeConstraints(constraints)
    }
}
