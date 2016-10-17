//
//  ViewController.swift
//  Punchcard
//
//  Created by Sklar, Josh on 10/10/16.
//  Copyright © 2016 StockX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var punchesRequiredTextField: UITextField!
    @IBOutlet weak var punchesReceivedTextField: UITextField!
    @IBOutlet weak var rewardTextTextField: UITextField!
    @IBOutlet weak var punchCardView: PunchcardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        punchesRequiredTextField.text = "3"
        punchesReceivedTextField.text = "1"
        rewardTextTextField.text = "FREE SHIPPING"
        
        textFieldShouldReturn(punchesReceivedTextField)
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        guard let punchesRequired = Int(punchesRequiredTextField.text ?? ""),
            let punchesReceived = Int(punchesReceivedTextField.text ?? ""),
            let rewardText = rewardTextTextField.text
            where punchesReceived <= punchesRequired else {
                return false
        }
        
        var state = punchCardView.state
        state.emptyPunchImage = UIImage(named: "punch-outline")
        state.filledPunchImage = UIImage(named: "punch")
        state.backgroundColor = UIColor(patternImage: UIImage(named: "punch_back_pattern")!)
        state.punchesRequired = punchesRequired
        state.punchesReceived = punchesReceived
        state.punchNumberColor = UIColor.lightGrayColor()
        state.rewardText = rewardText
        state.punchNumberFont = UIFont.systemFontOfSize(11)
        punchCardView.state = state
        
        return true
    }
}