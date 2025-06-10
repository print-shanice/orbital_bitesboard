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
        return try  snapshot.documents.compactMap({document in
            let review = try document.data(as: Review.self)
            return review
        })
    }
}
