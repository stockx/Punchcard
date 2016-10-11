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
    @IBOutlet weak var punchCardView: PunchcardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        punchesRequiredTextField.text = "4"
        punchesReceivedTextField.text = "1"
        
        textFieldShouldReturn(punchesReceivedTextField)
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        guard let punchesRequired = Int(punchesRequiredTextField.text ?? ""),
            let punchesReceived = Int(punchesReceivedTextField.text ?? "")
            where punchesReceived <= punchesRequired else {
                return false
        }
        
        var state = punchCardView.state
        state.punchesRequired = punchesRequired
        state.punchesReceived = punchesReceived
        state.punchNumberColor = UIColor.lightGrayColor()
        punchCardView.state = state
        
        return true
    }
}