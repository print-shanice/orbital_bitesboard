//
//  SearchViewModel.swift
//  BitesBoard
//
//  Created by lai shanice on 7/6/25.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var reviews: [Review] = []
    
    
    init(){
        Task{
            try await fetchAllUsers()
            try await fetchAllReviews()
        }
    }
    
    @MainActor
    func fetchAllUsers() async throws {
        self.users = try await UserService.fetchAllUsers()
    }
    
    @MainActor
    func fetchAllReviews() async throws {
        self.reviews = try await ReviewService.fetchFeedReviews()
    }
    
    @MainActor
    func fetchFilteredReviews(filters: ReviewFilters) async throws{
        let filteredReviews = try await ReviewService.fetchFeedReviewsWithFilter(filters: filters)
        self.reviews = filteredReviews

    }
}
