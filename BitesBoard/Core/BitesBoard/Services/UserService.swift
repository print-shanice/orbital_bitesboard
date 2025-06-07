//
//  UserService.swift
//  BitesBoard
//
//  Created by lai shanice on 7/6/25.
//

import Foundation
import Firebase

struct UserService {
    
    static func fetchAllUsers() async throws -> [User] {
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        return snapshot.documents.compactMap { try? $0.data(as: User.self)}
    }
}
