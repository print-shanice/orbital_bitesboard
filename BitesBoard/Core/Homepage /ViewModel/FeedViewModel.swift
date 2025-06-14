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
                    self.reviews = try await ReviewService.fetchFriendReviews(uid: user.id)
                case .favourites:
                    self.reviews = try await ReviewService.fetchFavouritereviews(uid: user.id)
                case .forYou:
                    self.reviews = try await ReviewService.fetchFeedReviews()
                case .bookmarks:
                    self.reviews = try await ReviewService.fetchBookmarkedReviews(uid: user.id)
                }
    }
    
    @MainActor
    func checkIfReviewLiked(reviewId: String) -> Bool {
        return user.favouritedReviews?.contains(reviewId) ?? false
    }
    
    @MainActor
    func checkIfReviewBookmarked(reviewId: String) -> Bool {
        return user.bookmarkedReviews?.contains(reviewId) ?? false
    }
    
    @MainActor
    func likeReview(reviewId: String) async throws{
        let uid = user.id
        do {
            try await ReviewService.likeReview(reviewId: reviewId, uid: uid)
        }
    }
    
    @MainActor
    func unlikeReview(reviewId: String) async throws {
        let uid = user.id
        do {
            try await ReviewService.unlikeReview(reviewId: reviewId, uid: uid)
        }
    }
    
    @MainActor
    func bookmarkReview(reviewId: String) async throws {
        let uid = user.id
        do {
            try await ReviewService.bookmarkReview(reviewId: reviewId, uid: uid)
        }
    }
    
    @MainActor
    func unbookmarkReview(reviewId: String) async throws {
        let uid = user.id
        do {
            try await ReviewService.unbookmarkReview(reviewId: reviewId, uid: uid)
        }
    }
    
}
