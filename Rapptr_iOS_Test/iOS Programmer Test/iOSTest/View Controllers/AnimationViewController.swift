//
//  AnimationViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit
import Lottie

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
    @IBOutlet weak var animationContainerView: UIView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Animation"
        addPanGesture()
        addAnimationView()
        animationView.isHidden = true
    }
    
    private func addPanGesture() {
        logoImageView.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        logoImageView.addGestureRecognizer(panGesture)
    }
    
    private func addAnimationView() {
        animationContainerView.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: view.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        
        if gesture.state == .changed {
            let translation = gesture.translation(in: view)
            logoImageView.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        }
        else if gesture.state == .ended {
            moveLogoToStartingPosition()
        }
    }
    
    private func moveLogoToStartingPosition() {
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.logoImageView.transform = .identity
        }
        AudioPlayer.playSound(for: "logo_sound")
    }

    @IBAction func didPressFade(_ sender: Any) {
        
        // toggles opacity
        logoImageView.fade(duration: animationDuration)
        
        // updates button title and animation view based on logo's visibility
        updateButtonTitle()
        updateAnimationView()
    }
    
    private func updateButtonTitle() {
        let title = logoVisible ? "FADE OUT" : "FADE IN"
        fadeInButton.setTitle(title, for: .normal)
    }
    
    private func updateAnimationView() {
        if logoVisible {
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                self.animationView.isHidden = false
                self.animationView.play()
            }
        }
        else {
            self.animationView.isHidden = true
            self.animationView.stop()
        }
    }
    
    private var logoVisible: Bool {
        logoImageView.layer.opacity != 0.0
    }
    
    // MARK: - Constants
    private let animationDuration: TimeInterval = 1.0
    
    
    // MARK: - Views
    var animationView: AnimationView = {
        var view = AnimationView()
        view.animation = Animation.named("fireworks")
        view.contentMode = .scaleAspectFit
        view.loopMode = .repeat(3.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}
