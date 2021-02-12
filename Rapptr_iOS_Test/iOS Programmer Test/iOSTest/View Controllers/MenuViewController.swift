//
//  MenuViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class MenuViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     *
     * 1) UI must work on iOS phones of multiple sizes. Do not worry about iPads.
     *
     * 2) Use Autolayout to make sure all UI works for each resolution
     *
     * 3) Use this starter project as a base and build upon it. It is ok to remove some of the
     *    provided code if necessary. It is ok to add any classes. This is your project now!
     *
     * 4) Read the additional instructions comments throughout the codebase, they will guide you.
     *
     * 5) Please take care of the bug(s) we left for you in the project as well. Happy hunting!
     *
     * Thank you and Good luck. - Rapptr Labs
     * =========================================================================================
     *
     *
     * 􀓣 ======================================================================================== 􀓣
     *
     * 1) I have created UI elements both in xib file and programmatically.
     *
     * 2) I have used MVVM architecture for this project. The goal was to have only view logic inside view controllers.
     *
     * 3) I have comments in some sections of the source code to explain my intent.
     *
     * Thank you, I had fun working on this test project. - Sajan Shrestha
     *
     * 􀓣 ======================================================================================== 􀓣
     
     */
    
    // MARK: - Outlets
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var animationButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        setUpButtons(chatButton, loginButton, animationButton)
    }
    
    // MARK: - Constants
    private let navigationTitle = "Coding Tasks"
    private let navigationTitleSize: CGFloat = 17.0
    private let buttonsCornerRadius: CGFloat = 8.0
}

// MARK:- UI Configurations

extension MenuViewController {
 
    private func setUpNavigationBar() {
        title = navigationTitle
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.05382280797, green: 0.3590119481, blue: 0.5361846685, alpha: 1)
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: navigationTitleSize, weight: .semibold)
        ]
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    }
    
    private func setUpButtons(_ buttons: UIButton...) {
        buttons.forEach { button in
            setInsets(for: button)
            button.layer.cornerRadius = buttonsCornerRadius
        }
    }
    
    private func setInsets(for button: UIButton) {
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 62, bottom: 0, right: 0)
    }
}

// MARK: - Actions
extension MenuViewController {
    @IBAction func didPressChatButton(_ sender: Any) {
        let chatViewModel = ChatRoom()
        let chatViewController = ChatViewController(model: chatViewModel)
        navigationController?.pushViewController(chatViewController, animated: true)
    }
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    @IBAction func didPressAnimationButton(_ sender: Any) {
        let animationViewController = AnimationViewController()
        navigationController?.pushViewController(animationViewController, animated: true)
    }
}
