//
//  TipViewController.swift
//  iOS-Assignment5
//
//  Created by Administlator on 2020/05/11.
//  Copyright © 2020 Administlator. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {
    var billing: Billing!

    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var tipAmountLabel: UILabel!
    @IBOutlet var tipRateTextField: UITextField!
    @IBOutlet var tipRateSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        calculate()
        tipRateTextField.addTarget(self, action: #selector(rateTextFieldDichanged(textField:)), for: .editingChanged)
        
    }
    
    func calculate() {
        let tip = Int(round(Double(billing.amount) * Double(billing.rate) / 100))
        amountLabel.text = String(billing.amount + tip)
        tipAmountLabel.text = String(tip)
        tipRateTextField.text = String(billing.rate)
    }
    
    @objc func rateTextFieldDichanged(textField: UITextField) {
        if textField.text == "" {
            billing.rate = 0
            tipRateSlider.setValue(0.0, animated: true)
            return
        }
        
        if ((textField.text ?? "").count > 5) {
            tipRateTextField.text = String(billing.rate)
            return
        }
        
        if let num = Int(textField.text ?? "0") {
            billing.rate = num
            tipRateSlider.setValue(Float(num) / 100, animated: true)
            calculate()
        } else {
            tipRateTextField.text = String(billing.rate)
        }
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        var currentValue = Int(round(sender.value * 100))
        billing.rate = currentValue
        calculate()
    }

}
