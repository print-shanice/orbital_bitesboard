//
//  ContinueSignUpView.swift
//  BitesBoard
//
//  Created by lai shanice on 1/6/25.
//

import SwiftUI

struct ContinueSignUpView: View {
    @State private var shouldNavigate = false
    @State private var errorMessage: String?
    @State private var showAlert = false

    @EnvironmentObject var viewModel: RegistrationViewModel
    

    var body: some View {
        VStack(spacing: 30) {
            Spacer(minLength: 80)

            // title
            HStack(spacing: 0) {
                Text("Become a ")
                    .foregroundColor(.black)
                Text("Biter ")
                    .foregroundColor(.red)
                    .fontDesign(.serif)
                Text("Today")
            }
            .font(.system(size: 32, weight: .bold))
            .padding(.bottom, 8)

            // create account
            VStack(spacing: 12) {
                Text("Create an account")
                    .font(.headline)
                    .font(.system(size: 20, weight: .bold))

                Text("Create personalised UserID")
                    .font(.subheadline)

                TextField("Enter username", text: $viewModel.username)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)

                Text("Create secure password")
                    .font(.subheadline)

                TextField("Enter password", text: $viewModel.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .padding(.horizontal)

            // continue button
            Button(action: {
                Task {
                    guard !viewModel.username.isEmpty else {
                        errorMessage = "UserID cannot be empty."
                        showAlert = true
                        return
                    }

                    guard viewModel.password.count >= 6 else {
                        errorMessage = "Password must be at least 6 characters."
                        showAlert = true
                        return
                    }
                    
                    guard isValidEmail(viewModel.email) else {
                        errorMessage = "Invalid email address. Please go back and try again."
                        showAlert = true
                        return
                    }

                    do {
                        try await viewModel.createUser()
                        shouldNavigate = true
                        } catch {
                         errorMessage = error.localizedDescription
                             showAlert = true
                        }
                    }
                }) {
                    Text("Continue")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(10)
            }

            .padding(.horizontal)
            .padding(.top, 10)

            Spacer()
                .padding(.top)
        }

        
        //popup for failed sign up
        .alert("Sign Up Failed", isPresented: $showAlert, actions: {
            Button("OK", role: .cancel) { }
        }, message: {
            Text(errorMessage ?? "An unknown error occurred.")
        })
    }
}

func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
    return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
}



struct ContinueSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ContinueSignUpView()
    }
}
