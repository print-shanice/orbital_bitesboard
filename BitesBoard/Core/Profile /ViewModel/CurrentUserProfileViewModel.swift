//
//  CurrentUserProfileViewModel.swift
//  BitesBoard
//
//  Created by lai shanice on 10/6/25.
//
import Foundation

class CurrentUserProfileViewModel: ObservableObject {
    private let user: User
    @Published var favouriteReviews = [Review]()
    @Published var recentReviews: [Review] = []
    
    init(user: User){
        self.user = user
        
        Task {
            try await fetchUserReviews()
            try await fetchUserFavourites()
        }
    }
    
    @MainActor
    func fetchUserReviews() async throws {
        self.recentReviews = try await ReviewService.fetchUserReviews(uid: user.id)
        
        for i in 0..<recentReviews.count{
            recentReviews[i].user = self.user
        }
    }
    
    @MainActor
    func fetchUserFavourites() async throws {
        self.favouriteReviews = try await ReviewService.fetchUserFavourites(uid: user.id)
        for i in 0..<favouriteReviews.count{
            favouriteReviews[i].user = self.user
        }
    }
    
    
}
