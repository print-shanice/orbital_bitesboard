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
    
    static func fetchUserFollowers(withUID uid: String) async throws -> [User] {
        let snapshot = try await usersCollection.document(uid).getDocument()
        guard let user = try? snapshot.data(as: User.self),
              let followerIDs = user.followers else {
            return []
        }
        
        var users: [User] = []
        
        for id in followerIDs {
            let followerUser = try await fetchUserWithUID(withUID: id)
            users.append(followerUser)
        }
        
        return users
    }
    
    static func fetchUserFollowings(withUID uid: String) async throws -> [User] {
        let snapshot = try await usersCollection.document(uid).getDocument()
        guard let user = try? snapshot.data(as: User.self),
              let followingIDs = user.following else {
            return []
        }
        
        var users: [User] = []
        
        for id in followingIDs {
            let followedUser = try await fetchUserWithUID(withUID: id)
            users.append(followedUser)
        }
        
        return users
    }
}
