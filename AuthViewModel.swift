//
//  AuthViewModel.swift
//  BitesBoard
//
//  Created by lai shanice on 1/6/25.
//

import Foundation
import FirebaseAuth
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init(){
        
    }
    
    func logIn(withEmail email: String, password:String) async throws{
        print("login")
    }
    
    func createUser(withEmail email: String, password:String, username:String) async throws{
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, email: email, username: username)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(result.user.uid).setData(encodedUser)
        } catch{
            print("DEBUG: Failed to create user: \(error)")
        }
    }
    
    func signOut(){
        
    }
    
    func deleteUser(){
        
    }
    
    func fetchUserData() async{
        
    }
}
