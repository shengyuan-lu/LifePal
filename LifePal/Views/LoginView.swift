//
//  LoginView.swift
//  LifePal
//
//  Created by Shengyuan Lu on 6/2/23.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    
    @Binding var isLoggedin: Bool
    
    @State private var isLoggingin = false
    
    var body: some View {
        
        if isLoggingin {
            
            LoadingView()
            
        } else {
            VStack {
                Text("Welcome To LifePal")
                    .font(.largeTitle)
                    .padding(.bottom, 50)
                
                TextField("Username", text: $username)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                if errorMessage != "" {
                    Text(errorMessage)
                        .bold()
                        .foregroundColor(.red)
                        .padding()
                }
                
                Button(action: {
                    login()
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10.0)
                }
            }
            .padding()
        }
        
       
    }
    
    func login() {
        
        if username.lowercased() == "anteater" && password != "" {
            
            self.isLoggingin = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                 // After 2 seconds, set isLoggedIn back to false and show the login screen
                self.isLoggedin = true
             }
            
        } else {
            errorMessage = "Username or password is not correct!"
        }
    
    }
}
