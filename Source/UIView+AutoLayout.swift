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
}
