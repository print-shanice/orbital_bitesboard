//
//  Review.swift
//  BitesBoard
//
//  Created by lai shanice on 4/6/25.
//

import Foundation

struct Review: Identifiable, Hashable, Codable {
    let id: String
    let ownerId: String
    let restaurantName: String
    let foodPhoto: String
    let caption: String
    let starRating: Double
    let timestamp: Date
    
    var user: User?
    var isBookmarked: Bool = false
    var isLiked: Bool = false
    var likesCount: Int = 0

    init(id: String = UUID().uuidString,
         ownerId: String,
         restaurantName: String,
         foodPhoto: String,
         caption: String,
         starRating: Double,
         timestamp: Date,
         user: User? = nil,
         isBookmarked: Bool = false,
         isLiked: Bool = false,
         likesCount: Int = 0) {
        self.id = id
        self.ownerId = ownerId
        self.restaurantName = restaurantName
        self.foodPhoto = foodPhoto
        self.caption = caption
        self.starRating = starRating
        self.timestamp = timestamp
        self.user = user
        self.isBookmarked = isBookmarked
        self.isLiked = isLiked
        self.likesCount = likesCount
    }
}

extension Review {
    static var MOCK_REVIEWS: [Review] = [
        Review(ownerId: UUID().uuidString, restaurantName: "Ikseoyang", foodPhoto: "food", caption: "zhen zhen would love this", starRating: 4.5, timestamp: Date(), user: User.MOCK_USERS[0]),
        Review(ownerId: UUID().uuidString, restaurantName: "Regh", foodPhoto: "food2", caption: "zhen zhen would love this", starRating: 2.5, timestamp: Date(), user: User.MOCK_USERS[1]),
        Review(ownerId: UUID().uuidString, restaurantName: "Ikang", foodPhoto: "food3", caption: "zhen zhen would love this", starRating: 4, timestamp: Date(), user: User.MOCK_USERS[2]),
        Review(ownerId: UUID().uuidString, restaurantName: "Dig", foodPhoto: "food4", caption: "zhen zhen would love this", starRating: 3.5, timestamp: Date(), user: User.MOCK_USERS[3]),
        Review(ownerId: UUID().uuidString, restaurantName: "Dumb bar", foodPhoto: "food5", caption: "zhen zhen would love this", starRating: 3.5, timestamp: Date(), user: User.MOCK_USERS[4])
    ]
}
