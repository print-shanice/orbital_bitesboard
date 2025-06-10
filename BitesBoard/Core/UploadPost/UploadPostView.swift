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
    @State private var imagePickerPresented = false
    @State private var photoItem:  PhotosPickerItem?
    @StateObject var viewModel = UploadPostViewModel()
    @Binding var tabIndex : Int
    
    var body: some View {
        VStack{
            HStack{
                Button{
                    caption = ""
                    viewModel.selectedImage = nil
                    viewModel.postImage = nil
                    tabIndex = 0
                } label: {
                    Text("Cancel")
                }
                Spacer()
                
                Text("New Post")
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button{
                    Task {
                        try await viewModel.uploadReview(caption: caption)
                        caption = ""
                        viewModel.selectedImage = nil
                        viewModel.postImage = nil
                        tabIndex = 0
                    }
                } label: {
                    Text("Upload")
                        .fontWeight(.semibold)
                }
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading) {
                if let image = viewModel.postImage {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 350, height: 350)
                        .clipped()
                }
                
                StarRatingView(rating: 3.5)
                    .padding(.top)
                TextField("Enter your caption", text: $caption, axis: .vertical)
            }
            .padding(.horizontal)
        }
        .padding(.bottom, 200)
        
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
