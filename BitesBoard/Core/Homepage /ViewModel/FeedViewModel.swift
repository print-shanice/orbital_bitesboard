//
//  FeedViewModel.swift
//  BitesBoard
//
//  Created by lai shanice on 10/6/25.
//

import Foundation
import Firebase
import FirebaseFirestore

class FeedViewModel: ObservableObject {
    private let user: User
    @Published var reviews: [Review] = []
    
    init(user: User, column: HomepageColumn = .forYou){
        self.user = user
        Task{
            try await fetchPosts(for: column)
        }
    }
    
    @MainActor
    func fetchPosts(for column: HomepageColumn) async throws{
        switch column {
                case .following:
                    self.reviews = try await ReviewService.fetchFollowingReviews(uid: user.id)
                case .friends:
                    self.reviews = try await ReviewService.fetchFeedReviews()
                case .favourites:
                    self.reviews = try await ReviewService.fetchFeedReviews()
                case .forYou:
                    self.reviews = try await ReviewService.fetchFeedReviews()
                }
    }
}
