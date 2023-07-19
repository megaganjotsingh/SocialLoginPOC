//
//  SigninWithFacebookButton.swift
//  SocialLoginPOC
//
//  Created by Admin on 18/07/23.
//

import UIKit
import SwiftUI
import FBSDKLoginKit

struct SigninWithFacebook: UIViewControllerRepresentable {
    var onCompletion: ((_ profile: Profile?) -> ())
    var onFailure: ((String) -> ())

    init(onCompletion: @escaping ((_ profile: Profile?) -> ()), onFailure: @escaping ((String) -> ())) {
        self.onCompletion = onCompletion
        self.onFailure = onFailure
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = SigninWithFacebookController()
        controller.onCompletion = onCompletion
        controller.onFailure = onFailure
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

class SigninWithFacebookController: UIViewController {
    
    var onCompletion: ((_ profile: Profile?) -> ())?
    var onFailure: ((String) -> ())?
    
    let button = UIButton()
    let loginManager = LoginManager()

    override func viewDidLoad() {
        setUpButton()
    }
    
    override func viewDidLayoutSubviews() {
        button.frame = view.bounds
    }
    
    func setUpButton() {
        button.backgroundColor = .white
        button.setTitle("FB", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.layer.cornerRadius = 30
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 10
        
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        self.view.addSubview(button)
        
    }
    
    @objc func buttonAction() {
//        if let _ = AccessToken.current {
//            // Access token available -- user already logged in
//            // Perform log out
//
//            loginManager.logOut()
//        } else {
            // Access token not available -- user already logged out
            // Perform log in
            
        loginManager.logIn(permissions: [], from: self) { [weak self] (result, error) in
            
            // Check for error
            guard error == nil else {
                // Error occurred
                self?.onFailure?(error!.localizedDescription)
                return
            }
            
            // Check for cancel
            guard let result = result, !result.isCancelled else {
                self?.onFailure?("User cancelled login")
                return
            }
            
            // Successfully logged in            
            Profile.loadCurrentProfile { profile, error in
                if let error = error {
                    self?.onFailure?(error.localizedDescription)
                } else {
                    self?.onCompletion?(profile)
                }
            }
        }
//        }
    }
}
