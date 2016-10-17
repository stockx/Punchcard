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
        var achieved: Bool
        
        var unachievedColor: UIColor
        var achievedBackgroundColor: UIColor // Will be clear when the reward is unachieved
        var achievedTextColor: UIColor
        
        var text: String
        
        var textFont: UIFont
    }
    
    var state: State = State(achieved: false,
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
    let borderBuffer: CGFloat = 5
    
    private var label = UILabel()
    
    /// Used to draw the circular border around the `label`.
    private let circularBorderView = UIView()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(circularBorderView)
        circularBorderView.snp_makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        circularBorderView.addSubview(label)
        label.snp_makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        
        // Add aspect ration constraint
        addConstraint(NSLayoutConstraint(item: label,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: label,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0.0))
        
        label.numberOfLines = 0
        label.text = "FREE\nSHIPPING"
        label.textAlignment = .Center
        
        update()
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
        circularBorderView.layer.borderColor = state.unachievedColor.CGColor

        label.text = state.text
        label.font = state.textFont
        label.textColor = state.achieved ? state.achievedTextColor : state.unachievedColor
        circularBorderView.backgroundColor = state.achieved ? state.achievedBackgroundColor : UIColor.clearColor()
        
        circularBorderView.backgroundColor = UIColor.greenColor()
        backgroundColor = UIColor.redColor()
        label.backgroundColor = UIColor.blueColor()
    }
}
