//
//  FollowViewModel.swift
//  BitesBoard
//
//  Created by lai shanice on 12/6/25.
//

import Foundation

@MainActor
class FollowingViewModel: ObservableObject {
    @Published var user: User
    @Published var users = [User]()
    
    
    init(user: User){
        self.user = user
        Task {
            try await fetchFollowings()
        }
    }
    
    func fetchFollowings() async throws {
        self.users = try await UserService.fetchUserFollowings(withUID: user.id)
    }
}
