//
//  SettingsViewController.swift
//  Prework
//
//  Created by Kunal Mody on 8/7/21.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var Tip1: UITextField!
    @IBOutlet weak var Tip2: UITextField!
    @IBOutlet weak var Tip3: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Tip1.delegate = self
        Tip2.delegate = self
        Tip3.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        Tip1.text = defaults.string(forKey: "tip1")
        Tip2.text = defaults.string(forKey: "tip2")
        Tip3.text = defaults.string(forKey: "tip3")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        defaults.setValue(Tip1.text, forKey: "tip1")
        defaults.setValue(Tip2.text, forKey: "tip2")
        defaults.setValue(Tip3.text, forKey: "tip3")
        defaults.synchronize()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
