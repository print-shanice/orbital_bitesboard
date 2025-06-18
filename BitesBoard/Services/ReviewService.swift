//
//  PostService.swift
//  BitesBoard
//
//  Created by lai shanice on 10/6/25.
//

import Foundation
import Firebase

struct ReviewService{
    private static let ReviewCollection = Firestore.firestore().collection("reviews")
    
    static func fetchFeedReviews() async throws ->  [Review] {
        let snapshot = try await ReviewCollection.order(by: "timestamp", descending: true).getDocuments()
        var reviews = try  snapshot.documents.compactMap({document in
            let review = try document.data(as: Review.self)
            return review
        })
        
        for i in 0 ..< reviews.count{
            let review = reviews[i]
            let ownerUID = review.ownerId
            let reviewUser = try await UserService.fetchUserWithUID(withUID: ownerUID)
            reviews[i].user = reviewUser
        }
        return reviews
    }
    
    static func fetchUserReviews(uid: String) async throws -> [Review] {
        let user = try await UserService.fetchUserWithUID(withUID: uid)
        let snapshot = try await ReviewCollection
            .whereField("ownerId", isEqualTo: uid)
            .order(by: "timestamp", descending: true)
            .getDocuments()
        
        var reviews = try snapshot.documents.compactMap { try $0.data(as: Review.self) }
        for i in 0..<reviews.count {
            reviews[i].user = user
        }
        
        return reviews
    }

    
    static func fetchFollowingReviews(uid: String) async throws -> [Review]{
        let user = try await UserService.fetchUserWithUID(withUID: uid)
        guard let userFollowing = user.following else { return [] }
        
        let snapshot = try await ReviewCollection.whereField("ownerId", in: userFollowing).order(by: "timestamp", descending: true).getDocuments()
        var reviews = try snapshot.documents.compactMap({try $0.data(as: Review.self)})
        for i in 0..<reviews.count {
                let user = try await UserService.fetchUserWithUID(withUID: reviews[i].ownerId)
                reviews[i].user = user
        }
        
        return reviews
    }
    
    static func fetchFriendReviews(uid: String) async throws -> [Review]{
        let user = try await UserService.fetchUserWithUID(withUID: uid)
        guard let userFollowing = user.following else { return [] }
        guard let userFollowers = user.followers else { return [] }
        let mutuals = Set(userFollowing).intersection(Set(userFollowers))
        guard !mutuals.isEmpty else { return [] }
        
        let snapshot = try await ReviewCollection.whereField("ownerId", in: Array(mutuals)).order(by: "timestamp", descending: true).getDocuments()
        var reviews = try snapshot.documents.compactMap({try $0.data(as: Review.self)})
        for i in 0..<reviews.count {
                let user = try await UserService.fetchUserWithUID(withUID: reviews[i].ownerId)
                reviews[i].user = user
        }
        
        return reviews
        
        
    }
    
    
    
    static func fetchForYouReviews(uid: String) async throws -> [Review]{
        let user = try await UserService.fetchUserWithUID(withUID: uid)
        guard let userDietaryRestrictions = user.dietaryRestrictions else { return try await fetchFeedReviews()}
        
        if userDietaryRestrictions.contains("None") || userDietaryRestrictions.isEmpty{
            return try await fetchFeedReviews()
        }
        
        let snapshot = try await ReviewCollection.whereField("dietaryTags" , arrayContainsAny: userDietaryRestrictions).order(by: "timestamp", descending: true).getDocuments()
        var reviews = try snapshot.documents.compactMap({try $0.data(as: Review.self)})
        
        for i in 0..<reviews.count {
                let user = try await UserService.fetchUserWithUID(withUID: reviews[i].ownerId)
                reviews[i].user = user
        }
        
        return reviews
    }
    
    static func fetchFavouritereviews(uid: String) async throws -> [Review]{
        let user = try await UserService.fetchUserWithUID(withUID: uid)
        guard let userFavourited = user.favouritedReviews else { return [] }
        
        let snapshot = try await ReviewCollection.whereField("id", in: userFavourited).order(by: "timestamp", descending: true).getDocuments()
        var reviews = try snapshot.documents.compactMap({try $0.data(as: Review.self)})
        for i in 0..<reviews.count {
                let user = try await UserService.fetchUserWithUID(withUID: reviews[i].ownerId)
                reviews[i].user = user
        }
        
        return reviews
    }
    
    static func fetchBookmarkedReviews(uid: String) async throws -> [Review]{
        let user = try await UserService.fetchUserWithUID(withUID: uid)
        guard let userBookmarked = user.bookmarkedReviews else { return [] }
        
        let snapshot = try await ReviewCollection.whereField("id", in: userBookmarked).order(by: "timestamp", descending: true).getDocuments()
        var reviews = try snapshot.documents.compactMap({try $0.data(as: Review.self)})
        for i in 0..<reviews.count {
                let user = try await UserService.fetchUserWithUID(withUID: reviews[i].ownerId)
                reviews[i].user = user
        }
        
        return reviews
    }
    
    static func likeReview(reviewId: String, uid: String) async throws {
        let reviewRef = Firestore.firestore().collection("reviews").document(reviewId)
        let userRef = Firestore.firestore().collection("users").document(uid)

        let batch = Firestore.firestore().batch()
        batch.updateData(["favouritedBy": FieldValue.arrayUnion([uid])], forDocument: reviewRef)
        batch.updateData(["favouritedReviews": FieldValue.arrayUnion([reviewId])], forDocument: userRef)
        try await batch.commit()
    }

    static func unlikeReview(reviewId: String, uid: String) async throws {
        let reviewRef = Firestore.firestore().collection("reviews").document(reviewId)
        let userRef = Firestore.firestore().collection("users").document(uid)

        let batch = Firestore.firestore().batch()
        batch.updateData(["favouritedBy": FieldValue.arrayRemove([uid])], forDocument: reviewRef)
        batch.updateData(["favouritedReviews": FieldValue.arrayRemove([reviewId])], forDocument: userRef)
        try await batch.commit()
    }
    
    static func bookmarkReview(reviewId: String, uid: String) async throws {
        let reviewRef = Firestore.firestore().collection("reviews").document(reviewId)
        let userRef = Firestore.firestore().collection("users").document(uid)
        
        let batch = Firestore.firestore().batch()
        batch.updateData(["bookmarkedBy": FieldValue.arrayUnion([uid])], forDocument: reviewRef)
        batch.updateData(["bookmarkedReviews": FieldValue.arrayUnion([reviewId])], forDocument: userRef)
        try await batch.commit()
    }
    
    static func unbookmarkReview(reviewId: String, uid: String) async throws {
        let reviewRef = Firestore.firestore().collection("reviews").document(reviewId)
        let userRef = Firestore.firestore().collection("users").document(uid)
        
        let batch = Firestore.firestore().batch()
        batch.updateData(["bookmarkedBy": FieldValue.arrayRemove([uid])], forDocument: reviewRef)
        batch.updateData(["bookmarkedReviews": FieldValue.arrayRemove([reviewId])], forDocument: userRef)
        try await batch.commit()
    }
    
    
    static func fetchFeedReviewsWithFilter(filters: ReviewFilters) async throws -> [Review] {
        var query: Query = ReviewCollection
      
        if let rating = filters.minRating {
            query = query.whereField("starRating", isGreaterThanOrEqualTo: rating)
        }
     
        if let maxBudget = filters.maxBudget {
            query = query.whereField("price", isLessThanOrEqualTo: maxBudget)
        }
        
        if !filters.selectedCuisineCategories.isEmpty {
            let cuisines = filters.selectedCuisineCategories
            if cuisines.count == 1 {
                query = query.whereField("cuisine", isEqualTo: cuisines[0])
            } else if cuisines.count <= 10 {
                query = query.whereField("cuisine", in: cuisines)
            }
        }
        
        switch filters.sortBy {
        case .dateDesc:
            query = query.order(by: "timestamp", descending: true)
        case .ratingAsc:
            query = query.order(by: "starRating")
        case .ratingDesc:
            query = query.order(by: "starRating", descending: true)
        case .priceDesc:
            query = query.order(by: "price", descending: true)
        }
        
        let snapshot = try await query.getDocuments()
        var reviews = try snapshot.documents.compactMap { try $0.data(as: Review.self) }
        
        if !filters.selectedDietaryRestrictions.isEmpty && !filters.selectedDietaryRestrictions.contains("None") {
            let requiredTags = Set(filters.selectedDietaryRestrictions)
            reviews = reviews.filter { review in
                guard let tags = review.dietaryTags else { return false }
                let reviewTags = Set(tags)
                return requiredTags.isSubset(of: reviewTags)
            }
        }
        

        for i in 0..<reviews.count {
            let ownerUID = reviews[i].ownerId
            let user = try await UserService.fetchUserWithUID(withUID: ownerUID)
            reviews[i].user = user
        }
        
        return reviews
    }
    
    static func fetchUserFavourites(uid: String) async throws ->  [Review] {
        let user = try await UserService.fetchUserWithUID(withUID: uid)
        var query = ReviewCollection.whereField( "ownerId", isEqualTo: uid)
        query = query.order(by: "starRating", descending: true)
        let snapshot = try await query.limit(to: 4).getDocuments()
        
        var reviews = try snapshot.documents.compactMap { try $0.data(as: Review.self) }
        for i in 0..<reviews.count {
            reviews[i].user = user
        }
        
        return reviews
    }
    

    
}
