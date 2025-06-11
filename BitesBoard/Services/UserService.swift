//
//  UserService.swift
//  BitesBoard
//
//  Created by lai shanice on 7/6/25.
//

import Foundation
import Firebase

struct UserService {
    private static let usersCollection = Firestore.firestore().collection("users")
    
    static func fetchAllUsers() async throws -> [User] {
        let snapshot = try await usersCollection.getDocuments()
        return snapshot.documents.compactMap { try? $0.data(as: User.self)}
    }
    
    static func fetchUserWithUID(withUID uid: String) async throws -> User {
        
        let snapshot = try await usersCollection.document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
    
    
}
