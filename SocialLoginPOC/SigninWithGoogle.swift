//
//  SigninWithGoogleButton.swift
//  SocialLoginPOC
//
//  Created by Admin on 18/07/23.
//

import SwiftUI
import UIKit
import GoogleSignIn

struct SigninWithGoogle: UIViewControllerRepresentable {
    var onCompletion: (GIDProfileData?) -> ()
    var onFailure: ((String) -> ())
    
    init(onCompletion: @escaping (GIDProfileData?) -> (), onFailure: @escaping ((String) -> ())) {
        self.onCompletion = onCompletion
        self.onFailure = onFailure
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: "Client ID")
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = SigninWithGoogleController()
        controller.onCompletion = onCompletion
        controller.onFailure = onFailure
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

class SigninWithGoogleController: UIViewController {
    
    var onCompletion: ((GIDProfileData?) -> ())?
    var onFailure: ((String) -> ())?

    let button = UIButton()

    override func viewDidLoad() {
        setUpButton()
    }
    
    override func viewDidLayoutSubviews() {
        button.frame = view.bounds
    }
    
    func setUpButton() {
        //Adding text to the button
        button.backgroundColor = .white
        button.setTitle("Google", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.layer.cornerRadius = 30
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 10
        
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        self.view.addSubview(button)
    }

    @objc func buttonAction(sender: UIButton!) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] signInResult, error in
            guard error == nil else { return }
            guard let signInResult = signInResult else { return }
            let user = signInResult.user.profile
            self?.onCompletion?(user)
        }
    }
}
