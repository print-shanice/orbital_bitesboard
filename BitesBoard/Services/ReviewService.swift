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
        let snapshot = try await ReviewCollection.getDocuments()
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
    
    static func fetchUserReviews(uid: String ) async throws ->  [Review] {
        let snapshot = try await  ReviewCollection.whereField( "ownerId", isEqualTo: uid).getDocuments()
        return try snapshot.documents.compactMap({document in
            let review = try document.data(as: Review.self)
            return review
        })
    }
    
    static func fetchFollowingReviews(uid: String) async throws -> [Review]{
        let user = try await UserService.fetchUserWithUID(withUID: uid)
        guard let userFollowing = user.following else { return [] }
        
        let snapshot = try await ReviewCollection.whereField("ownerId", in: userFollowing).getDocuments()
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
        
        
        return []
    }
    
    static func fetchForYouReviews() async throws -> [Review]{
        return []
    }
    
    static func fetchFavouritereviews(uid: String) async throws -> [Review]{
        let user = try await UserService.fetchUserWithUID(withUID: uid)
        guard let userFavourited = user.favouritedReviews else { return [] }
        
        let snapshot = try await ReviewCollection.whereField("id", in: userFavourited).getDocuments()
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

}
