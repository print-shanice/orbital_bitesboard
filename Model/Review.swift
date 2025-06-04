//
//  Review.swift
//  BitesBoard
//
//  Created by lai shanice on 4/6/25.
//

import Foundation

struct Review: Identifiable {
    let id = UUID()
    let userName: String
    let restaurantName: String
    let foodPhotoName: String
    let caption: String
    let starRating: Double
    var isBookmarked: Bool = false
    var isLiked: Bool = false
    var likesCount: Int = 0
    var categories: Set<FeedCategory> = []
    
}

enum FeedCategory: String, CaseIterable, Identifiable {
    case following = "Following"
    case forYou = "For You"
    case favorites = "Favourites"

    var id: String { self.rawValue }
}

let sampleReviews: [Review] = [
    Review(userName: "JaJa", restaurantName: "Ikseoyang", foodPhotoName: "food", caption: "zhen zhen would love this", starRating: 4.5, isLiked: false, likesCount: 15, categories: [.forYou, .following]),
    Review(userName: "Janice", restaurantName: "Ikseoyang", foodPhotoName: "food", caption: "zhen zhen would love this", starRating: 4.5, isLiked: false, likesCount: 15, categories: [.forYou, .following]),
    Review(userName: "Janice", restaurantName: "Ikseoyang", foodPhotoName: "food", caption: "zhen zhen would love this", starRating: 4.5, isLiked: false, likesCount: 15, categories: [.forYou, .following]),
    Review(userName: "Janice", restaurantName: "Ikseoyang", foodPhotoName: "food", caption: "zhen zhen would love this", starRating: 4.5, isLiked: false, likesCount: 15, categories: [.forYou, .following]),
]

class ReviewsDataStore: ObservableObject {
    @Published var allReviews: [Review] = sampleReviews
    func updateReview(id: UUID, isLiked: Bool, likesCount: Int, isBookmarked: Bool) {
        if let index = allReviews.firstIndex(where: { $0.id == id }) {
            allReviews[index].isLiked = isLiked
            allReviews[index].likesCount = likesCount
            allReviews[index].isBookmarked = isBookmarked
        }
    }
}
