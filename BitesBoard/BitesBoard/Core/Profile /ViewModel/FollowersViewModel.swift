//
//  FollowersViewModel.swift
//  BitesBoard
//
//  Created by lai shanice on 12/6/25.
//

import Foundation

class FollowersViewModel : ObservableObject {
    @Published var user: User
    @Published var users = [User]()
    
    
    init(user: User){
        self.user = user
        Task {
            try await fetchFollowers()
        }
    }
    
    @MainActor
    func fetchFollowers() async throws {
        self.users = try await UserService.fetchUserFollowers(withUID: user.id)
    }
}
