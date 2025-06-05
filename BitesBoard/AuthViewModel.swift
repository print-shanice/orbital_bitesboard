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

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    private var authStateHandle: AuthStateDidChangeListenerHandle?
    var onGoingSession: Bool {
        userSession != nil
    }
    
    init() {
            authStateHandle = Auth.auth().addStateDidChangeListener { [weak self] auth, firebaseUser in
                DispatchQueue.main.async {
                    self?.userSession = firebaseUser

                    if let firebaseUser = firebaseUser {
                        Task {
                            await self?.loadUserData()
                        }
                    } else {
                        self?.currentUser = nil
                    }
                }
            }
    }
    
    deinit {
            if let handle = authStateHandle {
                Auth.auth().removeStateDidChangeListener(handle)
            }
        }
    
    func logIn(withEmail email: String, password:String) async throws{
        print("DEBUG: Firebase is attempting to sign in with email: '\(email)'")
        
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
        } catch{
            print("DEBUG: Failed to log in user: \(error)")
            throw error
        }
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
            throw error
        }
    }
    
    func signInWithGoogle() async throws {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            throw URLError(.badURL)
        }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        guard let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = await windowScene.windows.first?.rootViewController else {
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
            
        }
        
        func deleteUser(){
            
        }
        
        func loadUserData() async{
            
        }
}
