//
//  AnimationViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit
import Combine

class AnimationViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Logo should fade out or fade in when the user hits the Fade In or Fade Out button
     *
     * 3) User should be able to drag the logo around the screen with his/her fingers
     *
     * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation 
     *    section in Swfit to show off your skills. Anything your heart desires!
     *
     **/
    
    // MARK: - Outlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var fadeInButton: UIButton!
        
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animation"
        
        addPanGesture()
    }
    
    private func addPanGesture() {
        logoImageView.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        logoImageView.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        
        if gesture.state == .changed {
            let translation = gesture.translation(in: view)
            logoImageView.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        }
        else if gesture.state == .ended {
            UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn) {
                self.logoImageView.transform = .identity
            }
            AudioPlayer.playSound(for: "logo_sound")
        }
    }

    @IBAction func didPressFade(_ sender: Any) {
        logoImageView.fade(duration: animationDuration)
        updateButtonTitle()
    }
    
    private func updateButtonTitle() {
        let title = logoVisible ? "FADE OUT" : "FADE IN"
        fadeInButton.setTitle(title, for: .normal)
    }
    
    private var logoVisible: Bool {
        logoImageView.layer.opacity != 0.0
    }
    
    // MARK: - Constants
    private let animationDuration: TimeInterval = 1.2
}


extension UIView {
    
    func fade(duration: TimeInterval) {
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.layer.opacity = self.layer.opacity == 0.0 ? 1.0 : 0.0
        }
    }
}
