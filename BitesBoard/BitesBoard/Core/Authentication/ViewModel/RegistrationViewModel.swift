//
//  RegistrationViewModel.swift
//  BitesBoard
//
//  Created by lai shanice on 6/6/25.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    
    @MainActor
    func createUser() async throws{
        try await AuthService.shared.createUser(withEmail: email, password: password, username: username)
        
        username = ""
        email = ""
        password = ""
    }
}
