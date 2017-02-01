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

public class PunchcardView: UIView {
    
    public struct State {
        public var backgroundColor: UIColor
        public var borderColor: UIColor
        public var punchesRequired: Int
        public var punchesReceived: Int
        
        public var emptyPunchImage: UIImage?
        public var filledPunchImage: UIImage?
        
        public var rewardTextFont: UIFont
        public var rewardText: String
        public var rewardTextColor: UIColor
        public var rewardFillColor: UIColor // The color of the reward punch when it is achieved.
        
        public var punchNumberFont: UIFont
        public var punchNumberColor: UIColor
        
        public var rewardViewSize: CGSize {
            guard let emptyPunchImage = emptyPunchImage else {
                return .zero
            }
            
            return CGSize(width: max(emptyPunchImage.size.width, emptyPunchImage.size.height + 10 /* TODO: Make this based on the label height, as opposed to guessing */),
                          height: max(emptyPunchImage.size.width, emptyPunchImage.size.height + 10))
        }
        
        init() {
            self.backgroundColor = .white
            self.borderColor = .gray
            self.punchesRequired = 0
            self.punchesReceived = 0
            self.emptyPunchImage = nil
            self.filledPunchImage = nil
            self.rewardTextFont = .systemFont(ofSize: UIFont.systemFontSize)
            self.rewardText = ""
            self.rewardTextColor = .green
            self.rewardFillColor = .green
            self.punchNumberFont = .systemFont(ofSize: UIFont.systemFontSize)
            self.punchNumberColor = .lightGray
        }
    }
    
    public var state: State = State() {
        didSet {
            update(oldValue)
        }
    }
    
    /**
     The content view area for the punches.
     Slightly inset from the edges of the `PunchcardView`, and has a
     border around it.
     */
    fileprivate var punchesContentView = UIView()
    
    fileprivate var punchViews = [PunchView]()
    fileprivate var rewardView = RewardView(frame: .zero)
    fileprivate var spacerViews = [UIView]()
    
    // MARK: Init
    
    public init(state: State) {
        super.init(frame: CGRect.zero)
        initialize()
        self.state = state
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    fileprivate func initialize() {
        punchesContentView.backgroundColor = .clear
        punchesContentView.layer.borderWidth = 1.0
        addSubview(punchesContentView)
        
        punchesContentView.makeEdgesEqualToSuperview(inset: 5)

        layoutIfNeeded()
    }
    
    // MARK: View
    
    override public func updateConstraints() {
        guard let emptyPunchImage = state.emptyPunchImage else {
            super.updateConstraints()
            return
        }
        
        // Calculate if the PunchcardView has enough size to accommodate all punchViews.
        let punchNumberLabelHeight = NSString(string: "1").size(attributes: [NSFontAttributeName: state.punchNumberFont]).height
        let punchViewSize = CGSize(width: emptyPunchImage.size.width,
                                   height: emptyPunchImage.size.height + punchNumberLabelHeight)
        
        guard punchViewSize.height < punchesContentView.bounds.size.height &&
            (punchViewSize.width * CGFloat(state.punchesRequired)) + state.rewardViewSize.width < punchesContentView.bounds.size.width else {
                print("Punchcard: PunchcardView is either too short or too tall to support the punchViews given the punch image and number of punches.\nPunchViews will be cut off.")
                super.updateConstraints()
                return
        }
        
        // Make sure there are enough spacer views.
        guard spacerViews.count == punchViews.count + 1 + 1 /* 2 because 1 for the right side, and 1 for the left of the spacer view */ else {
            print("Punchcard: There are not enough spacer views to constrain all punch views and the reward view.")
            super.updateConstraints()
            return
        }
        
        for (index, punchView) in punchViews.enumerated() {
            // If it is the first element, grab the first spacer view and constrain
            // it to the left and the right of the first punch view.
            if index == 0 {
                let firstSpacerView = spacerViews[index]
                
                firstSpacerView.removeAllConstraints()
                firstSpacerView.makeAttributeEqualToSuperview(.left)
                firstSpacerView.makeAttribute(.height, equalTo: 0)
                firstSpacerView.makeAttribute(.right, equalToOtherView: punchView, attribute: .left)
                firstSpacerView.makeAttributeEqualToSuperview(.centerY)
            }
            
            // If it's somewhere in the middle of the end, anchor the left spacer
            // view to the right of the previous punchView and to the left of the
            // punchView, and equal width/height to the previous spacer.
            if index > 0 && index <= (punchViews.count - 1) {
                let leftSpacerView = spacerViews[index]
                let previousSpacerView = spacerViews[index - 1]
                let previousPunchView = punchViews[index - 1]
                
                leftSpacerView.removeAllConstraints()
                leftSpacerView.makeAttribute(.height, equalToOtherView: previousSpacerView, attribute: .height)
                leftSpacerView.makeAttribute(.width, equalToOtherView: previousSpacerView, attribute: .width)
                leftSpacerView.makeAttributeEqualToSuperview(.centerY)
                
                leftSpacerView.makeAttribute(.left, equalToOtherView: previousPunchView, attribute: .right)
                leftSpacerView.makeAttribute(.right, equalToOtherView: punchView, attribute: .left)
            }
            
            // If it's the last one, anchor the right spacer view to the right of
            // the superview, and to the current punchView's left.
            if index == punchViews.count - 1 {
                let leftSpacerView = spacerViews[index]
                let rightSpacerView = spacerViews[index + 1]
                
                rightSpacerView.snp.remakeConstraints { make in
                    make.centerY.equalToSuperview()
                    make.width.equalTo(leftSpacerView.snp.width)
                    make.height.equalTo(leftSpacerView.snp.height)
                    
                    make.left.equalTo(punchView.snp.right)
                    make.right.equalTo(rewardView.snp.left)
                }
            }
            
            // snp.make, not snp.remake, since we don't want to blow away its
            // existing constraints.
            punchView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
            }
            
        }
        
        rewardView.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()

            make.width.equalTo(self.state.rewardViewSize.width)
            make.height.equalTo(self.state.rewardViewSize.height)
        }
        
        if let lastSpacerView = spacerViews.last,
            let firstSpacerView = spacerViews.first {
            lastSpacerView.snp.remakeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(rewardView.snp.right)
                make.right.equalToSuperview()
                
                make.width.equalTo(firstSpacerView.snp.width)
                make.height.equalTo(firstSpacerView.snp.height)
            }
        }
        
        super.updateConstraints()
    }
    
    // MARK: State
    
    func update(_ oldState: State) {
        // If the number of punches required has changed, remove the old ones
        // and add the new ones.
        if oldState.punchesRequired != state.punchesRequired {
            // Remove all punch views, spacer views, and reward view.
            punchViews.forEach {
                $0.removeFromSuperview()
            }
            spacerViews.forEach {
                $0.removeFromSuperview()
            }
            rewardView.removeFromSuperview()
            
            punchViews.removeAll()
            spacerViews.removeAll()
            
            for _ in 0..<state.punchesRequired {
                punchViews.append(PunchView(frame: .zero))
                spacerViews.append(UIView(frame:  .zero))
            }
            
            // Add one more for the rewardView
            spacerViews.append(UIView(frame: .zero))
            
            // Add one more spacer view for the right side.
            spacerViews.append(UIView(frame: .zero))
            
            punchViews.forEach {
                self.punchesContentView.addSubview($0)
            }
            spacerViews.forEach {
                self.punchesContentView.addSubview($0)
            }
            punchesContentView.addSubview(rewardView)
        }
        
        // Update all the punchViews state's.
        for (index, punchView) in punchViews.enumerated() {
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
        rewardViewState.borderColor = state.punchNumberColor
        rewardViewState.achievedBackgroundColor = state.rewardFillColor
        rewardViewState.achievedTextColor = .white // TODO: Add this to the state
        rewardViewState.unachievedTextColor = state.rewardTextColor
        rewardViewState.text = state.rewardText
        rewardViewState.textFont = state.rewardTextFont
        rewardView.state = rewardViewState
        
        backgroundColor = state.backgroundColor
        punchesContentView.layer.borderColor = state.borderColor.cgColor
        
        setNeedsUpdateConstraints()
    }
}
