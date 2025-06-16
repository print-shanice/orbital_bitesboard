//
//  UploadPostView.swift
//  BitesBoard
//
//  Created by lai shanice on 5/6/25.
//

import SwiftUI
import PhotosUI

struct UploadPostView: View {
    @State private var caption = ""
    @State private var restaurantName = ""
    @State private var selectedTags: [String] = []
    @State private var selectedCuisine: String? = nil
    @State private var imagePickerPresented = false
    @State private var photoItem:  PhotosPickerItem?
    @StateObject var viewModel = UploadPostViewModel()
    @Binding var tabIndex : Int
    @State private var rating: Double = 0.0
    @State private var priceInput: String = ""
    @State private var isUploading = false

    

    
    var body: some View {
        ScrollView {
            VStack{
                HStack{
                    Button{
                        caption = ""
                        restaurantName = ""
                        selectedTags = []
                        rating = 0.0
                        photoItem = nil
                        viewModel.selectedImage = nil
                        viewModel.postImage = nil
                        tabIndex = 0
                        selectedCuisine = nil
                        priceInput = ""
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(.red)
                    }
                    Spacer()
                    
                    Text("New Post")
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button {
                        isUploading = true
                        Task {
                            do {
                                try await viewModel.uploadReview(
                                    restaurantName: restaurantName,
                                    caption: caption,
                                    rating: rating,
                                    dietaryTags: selectedTags,
                                    cuisine: selectedCuisine ?? "",
                                    price: Int(priceInput) ?? 0
                                )
                                caption = ""
                                restaurantName = ""
                                selectedTags = []
                                rating = 0.0
                                selectedCuisine = nil
                                priceInput = ""
                                viewModel.selectedImage = nil
                                viewModel.postImage = nil
                                tabIndex = 0
                            } 
                            isUploading = false
                        }
                    } label: {
                        if isUploading {
                            ProgressView()
                        } else {
                            Text("Upload")
                                .fontWeight(.semibold)
                                .foregroundStyle(.red)
                        }
                    }
                    .disabled(isUploading)

                }
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
                
                VStack(alignment: .leading, spacing: 10) {
                    if let image = viewModel.postImage {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 350, height: 350)
                            .clipped()
                            .allowsHitTesting(false)
                    }
                    
                    InteractiveStarRatingView(rating: $rating)
                    
                    TextField("Enter your caption", text: $caption, axis: .vertical)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                .padding(.horizontal)
                .padding(.leading)
                .padding(.bottom, 10)
                
                HStack(spacing: 16){
                    TextField("Restaurant", text: $restaurantName)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .font(.headline)
                        .padding(.horizontal, 8)
                        .frame(height: 50)
                        .frame(width: 120)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray)
                        )
                    
                    DietaryTagsMenuView(selectedTags: $selectedTags)
                }
                .padding(.horizontal)
                .padding(.leading)
                
                HStack(spacing: 16){
                    HStack(spacing: 0){
                        Text("$")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                            .frame(height: 50)
                            .contentShape(Rectangle())
                        
                        TextField("0", text: $priceInput)
                            .keyboardType(.numberPad)
                            .font(.headline)
                            .padding(.horizontal, 8)
                            .frame(height: 50)
                    }
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray)
                    )
                    .frame(width: 120)
                    
                    
                    CuisineMenuView(selectedCuisine: $selectedCuisine)
                }
                .padding(.horizontal)
                .padding(.leading)
            }
            .padding(.horizontal)
            .padding(.top, 30)
            .padding(.bottom, 180)
        }
        .onAppear{
            imagePickerPresented.toggle()
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
    }
}



struct UploadPostView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPostView(tabIndex: .constant(0))
    }
}
