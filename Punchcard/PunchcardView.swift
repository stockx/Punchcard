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
        initialize()
        self.state = state
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        // Will trigger a setNeedsDisplay whenever bounds changes (i.e. orientation change)
        contentMode = .Redraw
        
        setNeedsDisplay()
        backgroundColor = UIColor.whiteColor()
    }
    
    // MARK: View
    
    override func drawRect(rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext(),
            let lineColor = state.punchNumberColor else {
                return
        }
        
        CGContextSaveGState(context)
        
        let insetRect = CGRectInset(rect, 10, 10)
        
        let path = CGPathCreateWithRect(insetRect, nil)
        CGContextSetLineWidth(context, 1)
        UIColor.clearColor().setFill()
        lineColor.setStroke()
        CGContextAddPath(context, path)
        CGContextDrawPath(context, .FillStroke)
        
        CGContextRestoreGState(context)
    }
    
    // MARK: State
    
    func update(oldState: State) {

        setNeedsDisplay()
    }
}
