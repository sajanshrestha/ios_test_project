//
//  LoginViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class LoginViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Take email and password input from the user
     *
     * 3) Use the endpoint and paramters provided in LoginClient.m to perform the log in
     *
     * 4) Calculate how long the API call took in milliseconds
     *
     * 5) If the response is an error display the error in a UIAlertController
     *
     * 6) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertController
     *
     * 7) When login is successful, tapping 'OK' in the UIAlertController should bring you back to the main menu.
     **/
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Properties
    private var client: LoginClient?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Login"
        setUpTextFields()
    }
    
    private func setUpTextFields() {
        emailTextField.setTextInset()
        passwordTextField.setTextInset()
                
        emailTextField.textColor = UIColor(red: 0.106, green: 0.118, blue: 0.122, alpha: 1)
        passwordTextField.textColor = UIColor(red: 0.106, green: 0.118, blue: 0.122, alpha: 1)
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .regular), .foregroundColor: UIColor(red: 0.373, green: 0.376, blue: 0.388, alpha: 1)])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .regular), .foregroundColor: UIColor(red: 0.373, green: 0.376, blue: 0.388, alpha: 1)])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        client = nil
    }
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        
        client = LoginClient()
        
        let userEmail = emailTextField.text!
        let userPassword = passwordTextField.text!
        
        guard !userEmail.isEmpty && !userPassword.isEmpty else {
            presentAlertController(title: "Error", message: "Please enter both username and password.") {
                print("fields empty")
            }
            return
        }
        
        client?.login(withEmail: userEmail, password: userPassword, completion: { responseDictionary in
            
            let success = responseDictionary?["Success"] as? Bool ?? false
            let timeTaken = responseDictionary?["NetworkingTime"] as? NSNumber ?? 0
            
            if success {
                DispatchQueue.main.async {
                    self.presentAlertController(title: "Success", message: "Time Taken: \(abs(timeTaken.intValue)) ms") {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
            else {
                print("not awesome")
            }
            
        })
        
    }
    
    private func presentAlertController(title: String, message: String, action: @escaping () -> Void) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            action()
        }
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}


extension UITextField {
    func setTextInset(left: CGFloat = 24, right: CGFloat = 24) {
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: left, height: 0))
        self.leftView = leftPadding
        self.leftViewMode = .always
        
        let rightPadding = UIView(frame: CGRect(x: 0, y: 0, width: right, height: 0))
        self.rightView = rightPadding
        self.rightViewMode = .always
    }
}
