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
        
        let emailPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 0))
        emailTextField.leftView = emailPaddingView
        emailTextField.leftViewMode = .always
        emailTextField.layer.opacity = 0.5
        
        let passwordPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 0))
        passwordTextField.leftView = passwordPaddingView
        passwordTextField.leftViewMode = .always
        passwordTextField.layer.opacity = 0.5  
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        let userEmail = emailTextField.text!
        let userPassword = passwordTextField.text!
        LoginClient.login(email: userEmail, password: userPassword) { success in
            if success {
                DispatchQueue.main.async {
                    self.presentAlertController()
                }
            }
        }
    }
    
    private func presentAlertController() {
        let alertController = UIAlertController(title: "Success", message: "It took 3 seconds for the call", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}
