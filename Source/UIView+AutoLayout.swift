//
//  UIView+AutoLayout.swift
//  Punchcard
//
//  Created by Josh Sklar on 2/1/17.
//  Copyright © 2017 StockX. All rights reserved.
//

import UIKit

extension UIView {

    /**
     Makes the edges of `firstView` equal to the edges of `secondView`.
     
     Note: `secondView` must already be constrained on `self`, and
     both `firstView` and `secondView` must already be subviews of `self`.
     */
    func makeEdgesOf(_ firstView: UIView, equalTo secondView: UIView) {
        firstView.translatesAutoresizingMaskIntoConstraints = false

        [.top, .bottom, .leading, .trailing].forEach {
            addConstraint(NSLayoutConstraint(item: firstView,
                                             attribute: $0,
                                             relatedBy: .equal,
                                             toItem: secondView,
                                             attribute: $0,
                                             multiplier: 1.0,
                                             constant: 0.0))
        }
    }
    
    /**
     Makes the edges of `view` equal to its superview with an otion to
     specify an inset value.
     
     Note: `view` must already be a subview of `self`.
     */
    func makeEdgesEqualToSuperview(_ view: UIView, inset: CGFloat = 0) {
        view.translatesAutoresizingMaskIntoConstraints = false

        let views = ["view": view]
        let metrics = ["inset": inset]

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-inset-[view]-inset-|",
                                                      options: [],
                                                      metrics: metrics,
                                                      views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-inset-[view]-inset-|",
                                                      options: [],
                                                      metrics: metrics,
                                                      views: views))
    }
}
