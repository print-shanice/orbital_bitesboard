//
//  LogInView.swift
//  BitesBoard
//
//  Created by lai shanice on 30/5/25.
//

import SwiftUI
import GoogleSignInSwift

struct LogInView: View {
    @State var viewModel = LogInViewModel()
    @State private var errorMessage: String?
    @State private var showAlert = false
    @State private var isLoading = false
    @State private var showForgotPassword = false
    @State private var resetEmail = ""
    @State private var showReset = false


    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            //title
            HStack(spacing: 0) {
                Text("Bites")
                    .foregroundColor(.red)
                    .fontDesign(.serif)
                Text("Board")
                    .foregroundColor(.black)
            }
            .font(.system(size: 32, weight: .bold))
            .padding(.bottom, 8)
            
            VStack(spacing:12){
                Text("Sign in to your account")
                    .font(.headline)
                    .font(.system(size: 20, weight: .bold))
                
                Text("Enter your email and password")
                    .font(.subheadline)
            }
            

            
            // user entry
            VStack(spacing: 12) {
                TextField("Enter email", text: $viewModel.email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                SecureField("Enter password", text: $viewModel.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .padding(.horizontal)

            // continue button
            Button {
                Task {
                    do {
                        isLoading = true
                        try await viewModel.signIn()
                    } catch{
                        errorMessage = error.localizedDescription
                        showAlert = true
                    }
                    isLoading = false
                }
            } label: {
                Text("Continue")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            //alert for failed login
            .alert("Login Error", isPresented: $showAlert) {
                            Button("OK", role: .cancel) { }
                        } message: {
                            Text(errorMessage ?? "An unkown error occured")
                        }
            //loading progress
            if isLoading {
                ProgressView()
                    .padding(.top)
            }

            // sign up here
            VStack(spacing: 4) {
                HStack(spacing: 4) {
                    Text("Don’t have an account?")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign up here")
                        .font(.footnote)
                        .foregroundColor(.blue)
                    }
                }
            }

            // 'or' divider
            HStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray.opacity(0.3))
                Text("or")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray.opacity(0.3))
            }
            .padding(.horizontal)

            // google sign in
            VStack(spacing: 12) {
                Button(action: {
                    Task{
                        do {
                            try await viewModel.signInWithGoogle()
                            
                        } catch {
                            errorMessage = error.localizedDescription 
                        }
                    }
                }) {
                    HStack {
                        Image("google")
                            .renderingMode(.original)
                        Text("Continue with Google")
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                }
            }
            .padding(.horizontal)

            // terms and privacy
            VStack(spacing: 1){
                Text("By clicking continue, you agree to our")
                    .font(.footnote)
                    .foregroundColor(.gray)
    
                Button(action: {
                }) {
                    Text("Terms of Service and Privacy Policy")
                        .font(.footnote)
                        .foregroundColor(.blue)
                }
            }
            

            Spacer()
        }
        .padding(.top)
    }
}






struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
