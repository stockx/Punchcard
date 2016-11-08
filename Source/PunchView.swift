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
        
        var punchNumber: Int
        
        var isFilled: Bool
        
        var punchNumberFont: UIFont?
        var punchNumberColor: UIColor?
    }
    
    fileprivate let emptyPunchImageView = UIImageView()
    fileprivate let filledPunchImageView = UIImageView()
    fileprivate let punchNumberLabel = UILabel()
    
    var state: State = State(emptyPunchImage: nil, filledPunchImage: nil, punchNumber: 0, isFilled: false, punchNumberFont: nil, punchNumberColor: nil) {
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
        
        punchNumberLabel.textAlignment = .center
        
        punchNumberLabel.snp_makeConstraints { make in
            make.top.equalTo(emptyPunchImageView.snp_bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        filledPunchImageView.snp_makeConstraints { make in
            make.edges.equalTo(self.emptyPunchImageView)
        }

        // Apply a transom translation and rotation to the filledPunchImageView
        let randomRotationValue = randomBetweenNumbers(0, secondNum: 0.1) * (arc4random_uniform(100) % 2 == 0 ? 1.0 : -1.0)
        let rotationTransform = CGAffineTransform(rotationAngle: randomRotationValue)
        let randomTranslationDX = randomBetweenNumbers(1.5, secondNum: 2.5) * (arc4random_uniform(100) % 2 == 0 ? 1.0 : -1.0)
        let randomTranslationDY = randomBetweenNumbers(1.5, secondNum: 2.5) * (arc4random_uniform(100) % 2 == 0 ? 1.0 : -1.0)
        let translationTransform = CGAffineTransform(translationX: randomTranslationDX, y: randomTranslationDY)
        filledPunchImageView.transform = rotationTransform.concatenating(translationTransform)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented. Please use init(frame:)")
    }
    
    // MARK: State
    
    func update() {
        emptyPunchImageView.image = state.emptyPunchImage
        filledPunchImageView.image = state.filledPunchImage
        filledPunchImageView.isHidden = !state.isFilled
        punchNumberLabel.text = "\(state.punchNumber)"
        punchNumberLabel.font = state.punchNumberFont
        punchNumberLabel.textColor = state.punchNumberColor
    }
    
    // MARK: Helper
    
    fileprivate func randomBetweenNumbers(_ firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random_uniform(1000)) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}
