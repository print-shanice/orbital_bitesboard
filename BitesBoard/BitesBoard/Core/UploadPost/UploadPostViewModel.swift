//
//  UploadPostViewModel.swift
//  BitesBoard
//
//  Created by lai shanice on 5/6/25.
//

import Foundation
import PhotosUI
import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

@MainActor
class UploadPostViewModel: ObservableObject {
    @Published var selectedImage: PhotosPickerItem? {
        didSet {Task {await loadImage(fromItem: selectedImage)}}
    }
    @Published var postImage: Image?
    private var uiImage: UIImage?
    
    func loadImage(fromItem item: PhotosPickerItem?) async{
        guard let item = item else {return}
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: data) else {return}
        self.postImage = Image(uiImage: uiImage)
        self.uiImage = uiImage
        
    }
    
    func uploadReview(restaurantName: String, caption: String, rating: Double, dietaryTags: [String], cuisine: String, price : Int) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let uiImage = uiImage else {return}
        let postRef = Firestore.firestore().collection("reviews").document()
        guard let imageURL = try await ImageUploader.uploadImage(image: uiImage) else {return}
        
        let review = Review(id: postRef.documentID, ownerId: uid, restaurantName: restaurantName, dietaryTags: dietaryTags, foodPhoto: imageURL, caption: caption, starRating: rating, timestamp: Timestamp(), price: price, cuisine: cuisine)
        guard let encodedReview = try? Firestore.Encoder().encode(review) else {return}
        
        try await postRef.setData(encodedReview)
        
    }
}
