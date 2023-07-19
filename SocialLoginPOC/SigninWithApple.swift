//
//  SigninWithApple.swift
//  SocialLoginPOC
//
//  Created by Admin on 19/07/23.
//

import UIKit
import SwiftUI
import AuthenticationServices

struct SigninWithApple: UIViewControllerRepresentable {
    var onCompletion: (ASAuthorizationAppleIDCredential?) -> ()
    var onFailure: ((String) -> ())
    
    init(onCompletion: @escaping (ASAuthorizationAppleIDCredential?) -> (), onFailure: @escaping ((String) -> ())) {
        self.onCompletion = onCompletion
        self.onFailure = onFailure
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = SigninWithAppleController()
        controller.onCompletion = onCompletion
        controller.onFailure = onFailure
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

class SigninWithAppleController: UIViewController {
//    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//
//    }
    
    var onCompletion: ((ASAuthorizationAppleIDCredential?) -> ())?
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
        button.setTitle("Apple", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.layer.cornerRadius = 30
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 10
        button.addTarget(self, action: #selector(actionHandleAppleSignin), for: .touchUpInside)
        self.view.addSubview(button)
    }

    @objc func actionHandleAppleSignin() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
//        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension SigninWithAppleController: ASAuthorizationControllerDelegate {

    // Authorization Failed
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        onFailure?(error.localizedDescription)
    }

    // Authorization Succeeded
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Get user data with Apple ID credentitial
            let userId = appleIDCredential.user
            let userFirstName = appleIDCredential.fullName?.givenName
            let userLastName = appleIDCredential.fullName?.familyName
            let userEmail = appleIDCredential.email
            print("User ID: \(userId)")
            print("User First Name: \(userFirstName ?? "")")
            print("User Last Name: \(userLastName ?? "")")
            print("User Email: \(userEmail ?? "")")
            onCompletion?(appleIDCredential)
            // Write your code here
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            // Get user data using an existing iCloud Keychain credential
            let appleUsername = passwordCredential.user
            let applePassword = passwordCredential.password
            // Write your code here
        }
    }
}
