//
//  User.swift
//  BitesBoard
//
//  Created by lai shanice on 3/6/25.


import Foundation

struct User : Identifiable, Codable {
    let id : String
    let email : String
    
    //account profile details
    var dietaryRestrictions : [String]? //store dietary restrictions as array
    var username : String
    var savedLocations : [Location]?
    var profilePicture : URL?
    var bio : String?
    var following: [String]?
    var followers: [String]?
    
    init(id: String,
             email: String,
             username: String,
             profilePicture: URL? = nil,
             bio: String? = nil,
             dietaryRestrictions: [String] = [],
             savedLocations: [Location]? = nil,
             following: [String]? = nil,
             followers: [String]? = nil)
            {
        
            self.id = id
            self.email = email
            self.dietaryRestrictions = dietaryRestrictions
            self.username = username
            self.savedLocations = savedLocations
            self.profilePicture = profilePicture
            self.bio = bio
            self.followers = followers
            self.following = following
    }

}

struct Location: Identifiable, Codable {
    var id = UUID()
    var name: String
    var street: String
    var city: String
    var postalCode: String
    var latitude: Double?
    var longitude: Double?
}
