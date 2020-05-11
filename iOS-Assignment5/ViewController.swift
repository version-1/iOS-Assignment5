//
//  ViewController.swift
//  iOS-Assignment5
//
//  Created by Administlator on 2020/05/11.
//  Copyright © 2020 Administlator. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var billing: Billing = Billing()
    var value: String = ""

    @IBOutlet var billAmountTextField: UITextField!
    @IBOutlet var calculateButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateButton.isEnabled = false
        billAmountTextField.text = value
        billAmountTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav = segue.destination as! UINavigationController
        let tipViewController = nav.topViewController as! TipViewController
        tipViewController.billing = billing
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        if textField.text == "" {
            billing.amount = 0
            calculateButton.isEnabled = true
            return
        }
        if ((textField.text ?? "").count > 8) {
            billAmountTextField.text = value
            calculateButton.isEnabled = false
            return
        }
        if let num = Int(textField.text ?? "0") {
            calculateButton.isEnabled = true
            billing.amount = num
            value = String(num)
        } else {
            billAmountTextField.text = value
        }
    }
}

