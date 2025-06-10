//
//  CurrentUserProfileViewModel.swift
//  BitesBoard
//
//  Created by lai shanice on 10/6/25.
//
import Foundation

class CurrentUserProfileViewModel: ObservableObject {
    private let user: User
    @Published var reviews = [Review]()
    
    init(user: User){
        self.user = user
        
        Task {
            try await fetchUserReviews()
        }
    }
    
    @MainActor
    func fetchUserReviews() async throws {
        self.reviews = try await ReviewService.fetchUserReviews(uid: user.id)
        
        for i in 0..<reviews.count{
            reviews[i].user = self.user
        }
    }
}
