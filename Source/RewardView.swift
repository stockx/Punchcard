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
        
        var borderColor: UIColor
        var achievedBackgroundColor: UIColor // Will be clear when the reward is unachieved
        var achievedTextColor: UIColor
        var unachievedTextColor: UIColor
        
        var text: String
        
        var textFont: UIFont
    }
    
    var state: State = State(achieved: false,
                             borderColor: UIColor.lightGrayColor(),
                             achievedBackgroundColor: UIColor.greenColor(),
                             achievedTextColor: UIColor.whiteColor(),
                             unachievedTextColor: UIColor.lightGrayColor(),
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
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.borderWidth = 1
        
        addSubview(label)
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
        
        layer.cornerRadius = bounds.size.height / 2
    }
    
    // MARK: State
    
    func update() {
        layer.borderColor = state.borderColor.CGColor

        label.text = state.text
        label.font = state.textFont
        label.textColor = state.achieved ? state.achievedTextColor : state.unachievedTextColor
        backgroundColor = state.achieved ? state.achievedBackgroundColor : UIColor.clearColor()
        setNeedsUpdateConstraints()
    }
}
