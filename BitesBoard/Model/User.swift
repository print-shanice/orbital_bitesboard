//
//  User.swift
//  BitesBoard
//
//  Created by lai shanice on 3/6/25.


import Foundation
import FirebaseAuth

struct User : Identifiable, Hashable, Codable {
    let id : String
    let email : String
    
    //account profile details
    var dietaryRestrictions : [String]?
    var username : String?
//    var savedLocations : [Location]?
    var profilePicture : String?
    var bio : String?
    var country: String?
    var following: [String]? //stored as user ids
    var followers: [String]? //stored as user ids
    var favouritedReviews: [String]? //stored as review ids
    var isCurrentUser: Bool  {
        guard let currentUID = Auth.auth().currentUser?.uid else { return false }
        return id == currentUID
    }
    
    init(id: String,
             email: String,
             username: String,
             profilePicture: String? = nil,
             bio: String? = nil,
             country: String? = nil,
             dietaryRestrictions: [String] = [],
//             savedLocations: [Location]? = nil,
             following: [String]? = nil,
             followers: [String]? = nil,
             favouritedReviews: [String]? = nil)
            {
        
            self.id = id
            self.email = email
            self.dietaryRestrictions = dietaryRestrictions
            self.username = username
//            self.savedLocations = savedLocations
            self.profilePicture = profilePicture
            self.bio = bio
            self.country = country
            self.followers = followers
            self.following = following
            self.favouritedReviews = favouritedReviews
    }

}

//struct Location: Identifiable, Codable {
//    var id = UUID()
//    var name: String
//    var street: String
//    var city: String
//    var postalCode: String
//    var latitude: Double?
//    var longitude: Double?
//}

extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, email: "janice@gmail.com", username: "janice", profilePicture: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Sunflower_from_Silesia2.jpg/1280px-Sunflower_from_Silesia2.jpg", bio: "i love zhen zhen"),
        .init(id: NSUUID().uuidString, email: "erika@gmail.com", username: "erika", profilePicture: "erika", bio: "i love zhen zhen"),
        .init(id: NSUUID().uuidString, email: "shaball@gmail.com", username: "shaball", profilePicture: "pfp", bio: "i love zhen zhen"),
        .init(id: NSUUID().uuidString, email: "ivis@gmail.com", username: "ivis", profilePicture: "ivis", bio: "i love zhen zhen"),
        .init(id: NSUUID().uuidString, email: "krystal@gmail.com", username: "krystal", profilePicture: "krystal", bio: "i love zhen zhen"),
        .init(id: NSUUID().uuidString, email: "levon@gmail.com", username: "levon", profilePicture: "levon", bio: "i love zhen zhen"),
        .init(id: NSUUID().uuidString, email: "janice@gmail.com", username: "janice", profilePicture: "janice", bio: "i love zhen zhen"),
    ]
}
