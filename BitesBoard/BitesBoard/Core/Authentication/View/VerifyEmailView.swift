//
//  VerifyEmailView.swift
//  BitesBoard
//
//  Created by lai shanice on 1/6/25.
//

import SwiftUI

struct VerifyEmailView: View {
    @State private var userID = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer(minLength: 100)
            //title
            VStack(spacing: 0){
                Image("email")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 120)
                    .foregroundColor(.black)
                Text("You're one step away!")
            }
            Spacer(minLength: 30)

            HStack(spacing: 0) {
                Text("Verify your email address")
                    .foregroundColor(.black)
            }
            .font(.system(size: 25, weight: .bold))
            .padding(.bottom, 8)
            
            VStack(spacing: 0){
                Text("Check your email and click the link to ")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("verify your email address")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
          
            Spacer(minLength: 50)
            VStack(spacing: 0){
                Text("Want to change your email address? ")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                HStack(spacing:0){
                    Text("Return to ")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    NavigationLink(
                        destination: SignUpView(),
                        label: {
                            Text("Sign up")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                    )
                }
            }
            Button(action: {
            }) {
                Text("Resend email")
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
    
            Spacer()
            .padding(.top)
        }
    }
    
}


struct VerifyEmailView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyEmailView()
    }
}

