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
    @Published var reviews: [Review] = []
    
    init(){
        Task{
            try await fetchPosts()
        }
    }
    
    @MainActor
    func fetchPosts() async throws{
        self.reviews = try await ReviewService.fetchFeedReviews()
    }
}
