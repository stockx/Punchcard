//
//  RewardView.swift
//  Punchcard
//
//  Created by Sklar, Josh on 10/11/16.
//  Copyright © 2016 StockX. All rights reserved.
//

import UIKit

// Libs
import SnapKit

/**
 Represents the last item on the Punchcard.
 
 Contains a circular label with text in it for the reward of filling
 every punch in the punchcard.
 */
class RewardView: UIView {
    
    struct State {
        var size: CGSize // The size of the rewardView is determined by the size of punch images image
        var achieved: Bool
        
        var unachievedColor: UIColor
        var achievedBackgroundColor: UIColor // Will be clear when the reward is unachieved
        var achievedTextColor: UIColor
        
        var text: String
        
        var textFont: UIFont
    }
    
    var state: State = State(size: CGSizeZero,
                             achieved: false,
                             unachievedColor: UIColor.lightGrayColor(),
                             achievedBackgroundColor: UIColor.greenColor(),
                             achievedTextColor: UIColor.whiteColor(),
                             text: "",
                             textFont: UIFont.systemFontOfSize(UIFont.systemFontSize())) {
        didSet {
            update()
        }
    }
    
    /**
     How much spacing there is on both sides of the label for the circular border.
     */
    let borderBuffer: CGFloat = 1
    
    private var label = UILabel()
    
    /// Used to draw the circular border around the `label`.
    private let circularBorderView = UIView()
    
    private var circularBorderViewWidthConstraint: NSLayoutConstraint!
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        circularBorderView.layer.borderWidth = 1
        circularBorderView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(circularBorderView)

        // Constrain the circularBorderView to the center of its superview.
        addConstraint(NSLayoutConstraint(item: circularBorderView,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: self,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0.0))
        addConstraint(NSLayoutConstraint(item: circularBorderView,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: self,
            attribute: .CenterY,
            multiplier: 1.0,
            constant: 0.0))
        
        // Add aspect ratio constraint to keep height equal to width.
        addConstraint(NSLayoutConstraint(item: circularBorderView,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: circularBorderView,
            attribute: .Height,
            multiplier: 1.0,
            constant: state.size.width))
        circularBorderViewWidthConstraint = NSLayoutConstraint(item: circularBorderView,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .NotAnAttribute,
            multiplier: 1.0,
            constant: 20)
        addConstraint(circularBorderViewWidthConstraint)
        
        circularBorderView.addSubview(label)
        label.snp_makeConstraints { make in
            make.edges.equalToSuperview().inset(self.borderBuffer)
        }
        
        
        label.numberOfLines = 0
        label.textAlignment = .Center
}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented. Please use init(frame:)")
    }
    
    // MARK: View
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        circularBorderView.layer.cornerRadius = circularBorderView.bounds.size.height / 2
    }
    
    // MARK: State
    
    func update() {
        circularBorderViewWidthConstraint.constant = state.size.width + borderBuffer
        circularBorderView.layer.borderColor = state.unachievedColor.CGColor

        label.text = state.text
        label.font = state.textFont
        label.textColor = state.achieved ? state.achievedTextColor : state.unachievedColor
        circularBorderView.backgroundColor = state.achieved ? state.achievedBackgroundColor : UIColor.clearColor()
        setNeedsUpdateConstraints()
    }
}
