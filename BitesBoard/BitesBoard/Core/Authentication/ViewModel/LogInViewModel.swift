//
//  LogInViewModel.swift
//  BitesBoard
//
//  Created by lai shanice on 6/6/25.
//

import Foundation

class LogInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        try await AuthService.shared.logIn(withEmail: trimmedEmail, password: password)
        print("DEBUG logging in with email: \(trimmedEmail) and password: \(password)")
    }
    
    func signInWithGoogle () async throws {
        try await AuthService.shared.signInWithGoogle()
    }
    

}
