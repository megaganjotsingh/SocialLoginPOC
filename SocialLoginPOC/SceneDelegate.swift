//
//  SceneDelegate.swift
//  SocialLoginPOC
//
//  Created by Admin on 19/07/23.
//

import Foundation
import FBSDKCoreKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // ...
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        let openURLContext = Array(URLContexts).first
        if openURLContext != nil {
            if let URL = openURLContext?.url, let annotation = openURLContext?.options.annotation {
                ApplicationDelegate.shared.application(UIApplication.shared, open: URL, sourceApplication: openURLContext?.options.sourceApplication, annotation: annotation)
            }
        }
    }
  
    // If your app has support for iOS 8, add the following method too
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
  
}
