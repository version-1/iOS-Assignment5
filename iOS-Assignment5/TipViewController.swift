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
    
    @IBOutlet var bottomViewConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        calculate()
        tipRateTextField.addTarget(self, action: #selector(rateTextFieldDichanged(textField:)), for: .editingChanged)
        NotificationCenter.default.addObserver(self,
               selector: #selector(self.keyboardNotification(notification:)),
               name: UIResponder.keyboardWillChangeFrameNotification,
               object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                self.bottomViewConstraint?.constant = 0.0
            } else {
                self.bottomViewConstraint?.constant = endFrame?.size.height ?? 0.0
            }
            UIView.animate(withDuration: duration,
                                       delay: TimeInterval(0),
                                       options: animationCurve,
                                       animations: { self.view.layoutIfNeeded() },
                                       completion: nil)
        }
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
