//
//  DeleteReviewsViewModel.swift
//  BitesBoard
//
//  Created by lai shanice on 21/6/25.
//

import Foundation
import Firebase

@MainActor
class DeleteReviewsViewModel: ObservableObject{
    @Published var user: User
    @Published var userReviews: [Review] = []
    
    init(user: User) {
        self.user = user
        self.userReviews = userReviews
        
        Task{
            try await fetchUserReviews()
        }
    }
    
    
    func fetchUserReviews() async throws {
        self.userReviews = try await ReviewService.fetchUserReviews(uid: user.id)
        
        for i in 0..<userReviews.count{
            userReviews[i].user = self.user
        }
    }
    
    func deleteReviewWithId(reviewId: String) async throws{
        try await ReviewService.deleteReview(reviewId: reviewId)
    }
}
