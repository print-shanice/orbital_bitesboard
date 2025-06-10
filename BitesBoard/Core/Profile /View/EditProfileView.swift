//
//  EditProfileView.swift
//  BitesBoard
//
//  Created by lai shanice on 7/6/25.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel:  EditProfileViewModel
    
    init(user: User){
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
        
    }
    
    var body: some View {
        VStack{
            //cancel and done buttons
            HStack{
                Button("Cancel"){
                    dismiss()
                }
                .foregroundStyle(.red)
                
                Spacer()
                
                Button{
                    Task{
                        try await viewModel.updateUserProfile()
                        dismiss()
                    }
                } label: {
                    Text("Done")
                }
                
                .foregroundStyle(.red)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            // header
            Text("Edit Your Profile")
                .font(.title2)
                .fontWeight(.bold)
            
            //pfp
            PhotosPicker(selection: $viewModel.selectedImage) {
                [profileImage = viewModel.profileImage, user = viewModel.user] in
                VStack {
                    if let image = profileImage {
                        image
                        . resizable()
                        .scaledToFill()
                        .frame(width: 100, height:100)
                        .clipShape(Circle())
                        .foregroundStyle(.gray)
                        .padding(.bottom, 5)
                    } else {
                        CircularProfileImageView(user: user, size: .large)
                    }
                    Text("Change Profile Picture")
                        .font(.footnote)
                        .padding(.bottom, 10)
                    Divider()
                }
            }
            .padding(.bottom , 10)
            
            //changing parts
            VStack(alignment: .leading, spacing: 6){
                
                Text("Username")
                TextField("Enter your username", text: $viewModel.username)
                    .padding(.bottom, 16)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                
                Text("Bio")
                TextField("Enter your bio", text: $viewModel.bio)
                    .padding(.bottom, 16)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                
                Text("Country")
                TextField("Enter your country", text: $viewModel.country)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
            }
            .padding(.leading)
            
        }
        .padding(.bottom, 300)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: User.MOCK_USERS[0])
    }
}

