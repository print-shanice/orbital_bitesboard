//
//  ContinueSignUpView.swift
//  BitesBoard
//
//  Created by lai shanice on 1/6/25.
//

import SwiftUI

struct ContinueSignUpView: View {
    @State private var userID = ""
    @State private var password = ""
    
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
            
            Spacer(minLength: 40)
            //create account
            VStack(spacing:12){
                Text("Create an account")
                    .font(.headline)
                    .font(.system(size: 20, weight: .bold))

                Text("Create personalised UserID")
                    .font(.subheadline)
                
                TextField("Enter userID", text: $userID)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                Text("Create secure password")
                    .font(.subheadline)
                
                TextField("Enter password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
            Button(action: {
            }) {
                Text("Continue")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            Spacer()
            .padding(.top)
        }
    }
    
}


struct ContinueSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ContinueSignUpView()
    }
}
