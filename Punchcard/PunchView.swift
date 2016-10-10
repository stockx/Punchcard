//
//  PunchView.swift
//  Punchcard
//
//  Created by Sklar, Josh on 10/10/16.
//  Copyright © 2016 StockX. All rights reserved.
//

import UIKit

class PunchView: UIView {
    
    struct State {
        var emptyPunchImage: UIImage?
        var filledPunchImage: UIImage?
        
        var isFilled: Bool
        
        var punchNumberFont: UIFont?
        var punchNumberColor: UIColor?
    }
    
    var state: State = State(emptyPunchImage: nil, filledPunchImage: nil, isFilled: false, punchNumberFont: nil, punchNumberColor: nil) {
        didSet {
            update()
        }
    }
    
    // MARK: Init
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented. Please use init(frame:)")
    }
    
    // MARK: State
    
    func update() {
        
    }
}
