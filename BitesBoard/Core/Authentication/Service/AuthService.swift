//
//  AuthViewModel.swift
//  BitesBoard
//
//  Created by lai shanice on 1/6/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import FirebaseCore

class AuthService {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    static let shared = AuthService()

    
    init() {
        Task{
            try await loadUserData()
        }
    }
    
    @MainActor
    func logIn(withEmail email: String, password:String) async throws{
        
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
        } catch{
            print("DEBUG: Failed to log in user: \(error)")
            throw error
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password:String, username:String) async throws{
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, email: email, username: username)
            self.currentUser = user
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(result.user.uid).setData(encodedUser)
        } catch{
            print("DEBUG: Failed to create user: \(error.localizedDescription)")
            throw error
        }
    }
    
    @MainActor
    func signInWithGoogle() async throws {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            throw URLError(.badURL)
        }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        guard let windowScene =  UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController =  windowScene.windows.first?.rootViewController else {
            throw NSError(domain: "NoRootVC", code: 0)
        }

        let signInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
        let user = signInResult.user
        guard let idToken = user.idToken?.tokenString else {
            throw NSError(domain: "MissingIDToken", code: 0)
        }

        let accessToken = user.accessToken.tokenString
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)

        let authResult = try await Auth.auth().signIn(with: credential)
        self.userSession = authResult.user
    }
        
        func signOut(){
            try? Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        }
        
        func deleteUser(){
            
        }
        
    @MainActor
        func loadUserData() async throws {
            self.userSession = Auth.auth().currentUser
            guard let currentUID = userSession?.uid else { return }
            
            let snapshot = try await Firestore.firestore().collection("users").document(currentUID).getDocument()
            self.currentUser = try? snapshot.data(as: User.self)
        }
}
