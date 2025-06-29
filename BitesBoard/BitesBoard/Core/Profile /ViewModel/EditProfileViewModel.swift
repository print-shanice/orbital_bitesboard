//
//  EditProfileViewModel.swift
//  BitesBoard
//
//  Created by lai shanice on 7/6/25.
//

import PhotosUI
import SwiftUI
import Firebase
import ImageIO

@MainActor
class EditProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var selectedImage: PhotosPickerItem? {
        didSet {Task {await loadImage(fromItem: selectedImage)}}
    }
    @Published var profileImage: Image?
    @Published var username = ""
    @Published var bio = ""
    @Published var country = ""
    @Published var dietaryRestrictions: [String] = []
    private var uiImage: UIImage?
    
    init(user:User){
        self.user = user
        
        if let username = user.username{
            self.username = username
        }
        
        if let bio = user.bio{
            self.bio = bio
        }
        
        if let country = user.country{
            self.country = country
        }
    }
    
    func loadImage(fromItem item: PhotosPickerItem?) async{
        guard let item = item else {return}
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: data) else {return}
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
        
    }
    
    func updateUserProfile() async throws {
        //update pfp
        
        var data = [String: Any]()
        
        if let uiImage = uiImage {
            let imageURL = try? await ImageUploader.uploadImage(image: uiImage)
            data["profilePicture"] = imageURL
        }
        
        //update username
        if !username.isEmpty  && user.username != username{
            data["username"] = username
        }
        
        //update bio
        if !bio.isEmpty  && user.bio != bio{
            data["bio"] = bio
        }
        
        //update country
        if !country.isEmpty  && user.country != country{
            data["country"] = country
        }
        
        if !data.isEmpty {
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
        }
    }
    
    func updateUserDietaryRestrictions() async throws {
        var data = [String: Any]()
        
        if !dietaryRestrictions.isEmpty {
            data["dietaryRestrictions"] = dietaryRestrictions
        }
        
        if !data.isEmpty {
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
        }
    }
}
