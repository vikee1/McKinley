//
//  ViewController.swift
//  McKinleyDemo
//
//  Created by Vikee Londhe on 20/03/20.
//  Copyright © 2020 Vikee Londhe. All rights reserved.
//

import UIKit

class MDLoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y = -keyboardHeight
        }
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
           self.view.frame.origin.y = 0
       }

    @IBAction func actionOnLoginButton(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            let post = ["\(emailTextField.text ?? "")":"\(self.passwordTextField.text ?? "")"]
             MDNetwrokManager.shared.getDataRequest(urlStr: MDConstants().baseURL, post: post) { (result, error) in
                
            }
        }
    }
}



