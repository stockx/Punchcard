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

class PunchcardView: UIView {
    
    struct State {
        var backgroundColor: UIColor
        var punchesRequired: Int
        var punchesReceived: Int
        
        var emptyPunchImage: UIImage?
        var filledPunchImage: UIImage?
        
        var rewardText: String
        
        var punchNumberFont: UIFont?
        var punchNumberColor: UIColor?
    }
    
    var state: State = State(backgroundColor: UIColor.whiteColor(),
                             punchesRequired: 0,
                             punchesReceived: 0,
                             emptyPunchImage: nil,
                             filledPunchImage: nil,
                             rewardText: "",
                             punchNumberFont: nil,
                             punchNumberColor: nil) {
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
    }
    
    // MARK: View
    
    override func updateConstraints() {
        punchesContentView.snp_remakeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        super.updateConstraints()
    }
    
    // MARK: State
    
    func update(oldState: State) {
        backgroundColor = state.backgroundColor
        punchesContentView.layer.borderColor = state.punchNumberColor?.CGColor
    }
}
