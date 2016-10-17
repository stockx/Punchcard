//
//  PunchcardView.swift
//  Punchcard
//
//  Created by Sklar, Josh on 10/10/16.
//  Copyright © 2016 StockX. All rights reserved.
//

import UIKit

// Libs
import SnapKit
import OAStackView

class PunchcardView: UIView {
    
    struct State {
        var backgroundColor: UIColor
        var punchesRequired: Int
        var punchesReceived: Int
        
        var emptyPunchImage: UIImage?
        var filledPunchImage: UIImage?
        
        var rewardText: String
        
        var punchNumberFont: UIFont
        var punchNumberColor: UIColor
    }
    
    var state: State = State(backgroundColor: UIColor.whiteColor(),
                             punchesRequired: 0,
                             punchesReceived: 0,
                             emptyPunchImage: nil,
                             filledPunchImage: nil,
                             rewardText: "",
                             punchNumberFont: UIFont.systemFontOfSize(UIFont.systemFontSize()),
                             punchNumberColor: UIColor.lightGrayColor()) {
        didSet {
            update(oldValue)
        }
    }
    
    /**
     The content view area for the punches.
     Slightly inset from the edges of the `PunchcardView`, and has a
     border around it.
     */
    private var punchesContentView = UIView()
    private var punchesStackView = OAStackView()
    
    private var punchViews = [PunchView]()
    private var rewardView = RewardView(frame: CGRectZero)
    
    // MARK: Init
    
    init(state: State) {
        super.init(frame: CGRect.zero)
        initialize()
        self.state = state
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        punchesContentView.backgroundColor = UIColor.clearColor()
        punchesContentView.layer.borderWidth = 1.0
        addSubview(punchesContentView)
        
        punchesContentView.snp_makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        punchesStackView.distribution = .FillProportionally
        punchesStackView.axis = .Horizontal
        punchesContentView.addSubview(punchesStackView)
        punchesStackView.snp_makeConstraints { make in
            make.edges.equalToSuperview()
        }

        layoutIfNeeded()
    }
    
    // MARK: View
    
    override func updateConstraints() {
        guard let emptyPunchImage = state.emptyPunchImage else {
            super.updateConstraints()
            return
        }
        
        // Calculate if the PunchcardView has enough size to accommodate all punchViews.
        let punchNumberLabelHeight = NSString(string: "1").sizeWithAttributes([NSFontAttributeName: state.punchNumberFont]).height
        let punchViewSize = CGSize(width: emptyPunchImage.size.width,
                                   height: emptyPunchImage.size.height + punchNumberLabelHeight)
        guard punchViewSize.height < punchesContentView.bounds.size.height &&
            punchViewSize.width * CGFloat(state.punchesRequired) < punchesContentView.bounds.size.width     else {
                print("Punchcard: PunchcardView is either too short or too tall to support the punchViews given the punch image and number of punches.\nPunchViews will be cut off.")
                super.updateConstraints()
                return
        }
        
        super.updateConstraints()
    }
    
    // MARK: State
    
    func update(oldState: State) {
        // If the number of punches required has changed, remove the old ones
        // and add the new ones.
        if oldState.punchesRequired != state.punchesRequired {
            punchViews.forEach {
                self.punchesStackView.removeArrangedSubview($0)
                self.punchesStackView.removeArrangedSubview(self.rewardView)
            }
            
            punchViews.removeAll()
            
            for _ in 0..<state.punchesRequired {
                punchViews.append(PunchView(frame: CGRectZero))
            }
            
            punchViews.forEach {
                self.punchesStackView.addArrangedSubview($0)
            }
            
            punchesStackView.addArrangedSubview(rewardView)
            
        }
        
        // Update all the punchViews state's.
        for (index, punchView) in punchViews.enumerate() {
            var punchViewState = punchView.state
            punchViewState.emptyPunchImage = state.emptyPunchImage
            punchViewState.filledPunchImage = state.filledPunchImage
            punchViewState.punchNumber = index + 1
            punchViewState.isFilled = index < state.punchesReceived
            punchViewState.punchNumberFont = state.punchNumberFont
            punchViewState.punchNumberColor = state.punchNumberColor
            
            punchView.state = punchViewState
        }
        
        // Update the rewardView's state.
        var rewardViewState = rewardView.state
        rewardViewState.achieved = state.punchesReceived == state.punchesRequired
        rewardViewState.unachievedColor = state.punchNumberColor
        rewardViewState.achievedBackgroundColor = UIColor.greenColor() // TODO: Add this to the state
        rewardViewState.achievedTextColor = UIColor.whiteColor() // TODO: Add this to the state
        rewardViewState.text = state.rewardText
        rewardViewState.textFont = state.punchNumberFont
        rewardView.state = rewardViewState
        
        backgroundColor = state.backgroundColor
        punchesContentView.layer.borderColor = state.punchNumberColor.CGColor
        
        setNeedsUpdateConstraints()
    }
}
