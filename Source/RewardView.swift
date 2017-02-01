//
//  RewardView.swift
//  Punchcard
//
//  Created by Sklar, Josh on 10/11/16.
//  Copyright © 2016 StockX. All rights reserved.
//

import UIKit

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
                             borderColor: .lightGray,
                             achievedBackgroundColor: .green,
                             achievedTextColor: .white,
                             unachievedTextColor: .lightGray,
                             text: "",
                             textFont: .systemFont(ofSize: UIFont.systemFontSize)) {
        didSet {
            update()
        }
    }
    
    /**
     How much spacing there is on both sides of the label for the circular border.
     */
    let borderBuffer: CGFloat = 1
    
    fileprivate var label = UILabel()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.borderWidth = 1
        
        addSubview(label)
        
        makeEdgesEqualToSuperview(label, inset: self.borderBuffer)
        
        label.numberOfLines = 0
        label.textAlignment = .center
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
        layer.borderColor = state.borderColor.cgColor

        label.text = state.text
        label.font = state.textFont
        label.textColor = state.achieved ? state.achievedTextColor : state.unachievedTextColor
        backgroundColor = state.achieved ? state.achievedBackgroundColor : .clear
        setNeedsUpdateConstraints()
    }
}
