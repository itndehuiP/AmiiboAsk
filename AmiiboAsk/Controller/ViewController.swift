//
//  ViewController.swift
//  AmiiboAsk
//
//  Created by ItandehuiP on 6/6/19.
//  Copyright © 2019 ItandehuiP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var goButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissParentVC()
    }
    
    /**
     It validates the data introduced and performs and action
 
     */
    @IBAction func signingGoButton(_ sender: Any) {
        if SessionManager.shared.validateData() {
            performSegue(withIdentifier: "SignToCollectionSegueIdentifier", sender: sender)
        } else {
            let invalidUserAlert = UIAlertController(title: "Información no válida", message: "Por favor verifica tu información e ingresa datos válidos", preferredStyle: .alert)
            invalidUserAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(invalidUserAlert, animated: true)
        }
        
    }
    ///It is called when username did end editing, and updates the user singleton
    @IBAction func usernameDidEndEditing(_ sender: Any) {
        if usernameTextField.text != "" {
            SessionManager.shared.user.name = usernameTextField.text!
            activateGoButton()
        }
    }
    ///It is called when password did end editing, and updates the user singleton
    @IBAction func passwordDidEndEditing(_ sender: Any) {
        if passwordTextField.text != "" {
            SessionManager.shared.user.password = passwordTextField.text!
            activateGoButton()
        }

    }
    
    ///It activates go button when the data has been fulfilled
    private func activateGoButton() {
        if SessionManager.shared.didFilledData() {
            goButton.isOpaque = false
            goButton.isEnabled = true
        } 
    }
    ///It dismisses presenting view controller
    func dismissParentVC() {
        guard let parentCV = self.presentingViewController as? ItemsCollectionController else { return }
        parentCV.dismiss(animated: false)
    }
}

extension ViewController : UITextFieldDelegate {
    ///It resigns first responder 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text! == "" {
            textField.resignFirstResponder()
            return true
        } else if textField == usernameTextField {
            usernameTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
            return false
        } else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
            return true
        } else {
            return false
        }
    }
}

