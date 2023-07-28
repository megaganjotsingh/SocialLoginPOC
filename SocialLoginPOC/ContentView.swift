//
//  ContentView.swift
//  SocialLoginPOC
//
//  Created by Admin on 18/07/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        HStack(spacing: 16) {
            appleSignInButton()
            googleSignInButton()
            facebookSigninButton()
        }
        .padding()
    }
    
    func appleSignInButton() -> some View {
        return SigninWithApple (
            onCompletion: { profile in
                print(profile)
            },
            onFailure: { error in
                // TODO: - Handle Error
            }
        )
        .frame(height: 60, alignment: .center)
    }
    
    func googleSignInButton() -> some View {
        return SigninWithGoogle(
            onCompletion: { profile in
                print(profile)
            },
            onFailure: { error in
                // TODO: - Handle Error
            }
        )
        .frame(height: 60, alignment: .center)
    }
    
    func facebookSigninButton() -> some View {
        return SigninWithFacebook(
            onCompletion: { profile in
                print(profile)
            },
            onFailure: { error in
                // TODO: - Handle Error
            }
        )
        .frame(height: 60, alignment: .center)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
