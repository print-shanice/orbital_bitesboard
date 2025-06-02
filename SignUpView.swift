//
//  SignUpView.swift
//  BitesBoard
//
//  Created by lai shanice on 1/6/25.
//

import SwiftUI

struct SignUpView : View {
    @State private var email = ""
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            //title
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
            
            //create account
            VStack(spacing:12){
                Text("Create an account")
                    .font(.headline)
                    .font(.system(size: 20, weight: .bold))
                
                Text("Enter your email to sign up")
                    .font(.subheadline)
            }
            
            //enter email
            TextField("Enter Email", text: $email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            
            //continue button
            NavigationLink(destination: ContinueSignUpView()) {
                           Text("Continue")
                               .foregroundColor(.white)
                               .padding()
                               .frame(maxWidth: .infinity)
                               .background(Color.black)
                               .cornerRadius(10)
                       }
            
            //'or' divisor
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
            
            //google sign up
            VStack(spacing: 12) {
                Button(action: {
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
        .padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
