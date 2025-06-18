//
//  Review.swift
//  BitesBoard
//
//  Created by lai shanice on 4/6/25.
//

import Foundation
import Firebase

struct Review: Identifiable, Hashable, Codable {
    let id: String
    let ownerId: String
    let restaurantName: String
    let dietaryTags: [String]?
    let foodPhoto: String
    let caption: String
    let starRating: Double
    let timestamp: Timestamp
    let price: Int
    let cuisine: String?
    
    var user: User?
    var bookmarkedBy: [String]?
    var favouritedBy: [String]?

    init(id: String = UUID().uuidString,
         ownerId: String,
         restaurantName: String,
         dietaryTags: [String]? = nil,
         foodPhoto: String,
         caption: String,
         starRating: Double,
         timestamp: Timestamp,
         price: Int,
         cuisine: String? = "",
         user: User? = nil,
         bookmarkedBy: [String]? = nil,
         favouritedBy: [String]? = nil)
          {
        self.id = id
        self.ownerId = ownerId
        self.restaurantName = restaurantName
        self.dietaryTags = dietaryTags
        self.foodPhoto = foodPhoto
        self.caption = caption
        self.starRating = starRating
        self.timestamp = timestamp
        self.price = price
        self.cuisine = cuisine
        self.user = user
        self.bookmarkedBy = bookmarkedBy
        self.favouritedBy = favouritedBy
    }
}

extension Review {
    static var MOCK_REVIEWS: [Review] = [
        Review(ownerId: UUID().uuidString, restaurantName: "Ikseoyang", dietaryTags: ["None"], foodPhoto: "food", caption: "zhen zhen would love this", starRating: 4.5, timestamp: Timestamp(), price: 15, cuisine: "Korean", user: User.MOCK_USERS[0]),
        Review(ownerId: UUID().uuidString, restaurantName: "Regh", dietaryTags: ["None"], foodPhoto: "food2", caption: "zhen zhen would love this", starRating: 2.5, timestamp: Timestamp(), price: 15,  user: User.MOCK_USERS[1]),
        Review(ownerId: UUID().uuidString, restaurantName: "Ikang", dietaryTags: ["None"], foodPhoto: "food3", caption: "zhen zhen would love this", starRating: 4, timestamp: Timestamp(), price: 15,  user: User.MOCK_USERS[2]),
        Review(ownerId: UUID().uuidString, restaurantName: "Dig", dietaryTags: ["None"],foodPhoto: "food4", caption: "zhen zhen would love this", starRating: 3.5, timestamp: Timestamp(), price: 15,  user: User.MOCK_USERS[3]),
        Review(ownerId: UUID().uuidString, restaurantName: "Dumb bar", dietaryTags: ["None"], foodPhoto: "food5", caption: "zhen zhen would love this", starRating: 3.5, timestamp: Timestamp(), price: 15,  user: User.MOCK_USERS[4])
    ]
}
