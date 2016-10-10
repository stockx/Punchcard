//
//  PunchcardView.swift
//  Punchcard
//
//  Created by Sklar, Josh on 10/10/16.
//  Copyright © 2016 StockX. All rights reserved.
//

import UIKit

class PunchcardView: UIView {
    
    struct State {
        var punchesRequired: Int
        var punchesReceived: Int
        
        var emptyPunchImage: UIImage?
        var filledPunchImage: UIImage?
        
        var rewardText: String
        
        var punchNumberFont: UIFont?
        var punchNumberColor: UIColor?
    }
    
    var state: State = State(punchesRequired: 0, punchesReceived: 0, emptyPunchImage: nil, filledPunchImage: nil, rewardText: "", punchNumberFont: nil, punchNumberColor: nil) {
        didSet {
            update(oldValue)
        }
    }
    
    // MARK: Init
    
    init(state: State) {
        super.init(frame: CGRect.zero)
        self.state = state
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: State
    
    func update(oldState: State) {
        
    }
    
    
}
