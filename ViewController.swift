//
//  ViewController.swift
//  Prework
//
//  Created by Kunal Mody on 8/7/21.
//

import UIKit
class ViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var billAmountTextView: UITextView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        billAmountTextView.becomeFirstResponder()
        let defaults = UserDefaults.standard
        let tips = [defaults.string(forKey: "tip1"), defaults.string(forKey: "tip2"), defaults.string(forKey: "tip3")]
        
        tipControl.setTitle(tips[0]! + "%", forSegmentAt: 0)
        tipControl.setTitle(tips[1]! + "%", forSegmentAt: 1)
        tipControl.setTitle(tips[2]! + "%", forSegmentAt: 2)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tip Calculator"
        billAmountTextView.delegate = self
    }
    
    // Used for making a textView the firstResponder
    override var canBecomeFirstResponder: Bool { true }
    
    // Used for calculating tip and totalBill
    @IBAction func calculateTip(_ sender: Any) {
        // Calculate tip only if textfield size is greater than 1
        if (billAmountTextView.text!.count > 1) {
            // Get bill from text field input
            let bill = Double(billAmountTextView.text!.suffix(billAmountTextView.text!.count - 1))
                
            // Get total tip by multiplying tip * tipPercentage
            let tipPercentages = [tipControl.titleForSegment(at: 0), tipControl.titleForSegment(at: 1), tipControl.titleForSegment(at: 2)]
            let wholeString = tipPercentages[tipControl.selectedSegmentIndex]!
            let percentage = Double(wholeString.prefix(wholeString.count - 1))
            let tip = bill! * percentage! / 100
            let total = bill! + tip
            
            // Update Tip Amount label
            tipAmountLabel.text = (String) (format: "$%.2f", tip)
            
            // Update total bill amount
            totalLabel.text = (String) (format: "$%.2f", total)
        }
        else {
            tipAmountLabel.text = (String) (format: "$%.2f", 0)
            totalLabel.text = (String) (format: "$%.2f", 0)
        }
    }
    // Used for keeping $ symbol in billAmount label, regardless of whether user tries to delete it
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText string: String) -> Bool {
        let protectedRange = NSMakeRange(0, 1)
        let intersection = NSIntersectionRange(protectedRange, range)
        if intersection.length > 0 {
            return false
        }
        return true
    }
    
    // Used for instantly updating tip and total bill labels after every change in user input
    func textViewDidChange(_ textView: UITextView) {
        calculateTip(self)
    }
    
    // Used for restricting cursor position
    func textViewDidChangeSelection(_ textView: UITextView) {
        let minLocation  = 1
        let currentRange = textView.selectedRange
        if (currentRange.location < minLocation) {
            let lengthDelta = (minLocation - currentRange.location)
            //Minus the number of characters moved so the end point of the selection does not change.
            let newRange = NSMakeRange(minLocation, currentRange.length - lengthDelta);
            //Should use UITextInput protocol
            textView.selectedRange = newRange;
        }
    }
}
