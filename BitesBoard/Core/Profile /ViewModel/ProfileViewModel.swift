//
//  ProfileViewModel.swift
//  BitesBoard
//
//  Created by lai shanice on 12/6/25.
//

import Firebase

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var followingUser: User
    @Published var followedUser: User
    @Published var isFollowing: Bool = false
    
    init(followingUser: User, followedUser: User) {
        self.followingUser = followingUser
        self.followedUser = followedUser
       
        Task {
            try await checkFollowing()
        }
    }
    
    
    func checkFollowing() async throws {
        let userFollowingData = try await UserService.fetchUserWithUID(withUID: followingUser.id).following ?? []
        if userFollowingData.contains(where: { $0 == followedUser.id }) {
            isFollowing = true
        }
    }
    
    func toggleFollowing() async throws -> Bool {
        var followingData = [String: Any]()
        var followedData = [String: Any]()
        let follow: Bool
        
        if isFollowing {
            followingData["following"] = FieldValue.arrayRemove([followedUser.id])
            followedData["followers"] = FieldValue.arrayRemove([followingUser.id]).self
            follow = false
        } else {
            followingData["following"] = FieldValue.arrayUnion([followedUser.id])
            followedData["followers"] = FieldValue.arrayUnion([followingUser.id])
            follow = true
        }
        
        if !followingData.isEmpty && !followedData.isEmpty{
            try await Firestore.firestore().collection("users").document(followingUser.id).updateData(followingData)
            try await Firestore.firestore().collection("users").document(followedUser.id).updateData(followedData)
        }
        isFollowing.toggle()
        return follow
    }
}
