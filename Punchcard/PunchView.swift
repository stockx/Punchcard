//
//  PunchView.swift
//  Punchcard
//
//  Created by Sklar, Josh on 10/10/16.
//  Copyright © 2016 StockX. All rights reserved.
//

import UIKit

// Libs
import SnapKit

class PunchView: UIView {
    
    struct State {
        var emptyPunchImage: UIImage?
        var filledPunchImage: UIImage?
        
        var isFilled: Bool
        
        var punchNumberFont: UIFont?
        var punchNumberColor: UIColor?
    }
    
    private let emptyPunchImageView = UIImageView()
    private let filledPunchImageView = UIImageView()
    private let punchNumberLabel = UILabel()
    
    var state: State = State(emptyPunchImage: nil, filledPunchImage: nil, isFilled: false, punchNumberFont: nil, punchNumberColor: nil) {
        didSet {
            update()
        }
    }
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(emptyPunchImageView)
        addSubview(filledPunchImageView)
        addSubview(punchNumberLabel)
        
        emptyPunchImageView.snp_makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        punchNumberLabel.textAlignment = .Center
        
        punchNumberLabel.snp_makeConstraints { make in
            make.top.equalTo(emptyPunchImageView.snp_bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        filledPunchImageView.snp_makeConstraints { make in
            make.edges.equalTo(self.emptyPunchImageView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented. Please use init(frame:)")
    }
    
    // MARK: State
    
    func update() {
        emptyPunchImageView.image = state.emptyPunchImage
        filledPunchImageView.image = state.filledPunchImage
        filledPunchImageView.highlighted = !state.isFilled
        punchNumberLabel.text = "1"
    }
}
