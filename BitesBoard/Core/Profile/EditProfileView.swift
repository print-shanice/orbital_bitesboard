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
    @State private var selectedImage: PhotosPickerItem?
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
                    print("Done")
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
            PhotosPicker(selection: $selectedImage) {
                VStack {
                    Image(systemName:"person.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height:100)
                        .clipShape(Circle())
                        .foregroundStyle(.gray)
                        .padding(.bottom, 5)
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
                TextField("Enter your username", text: .constant(""))
                    .padding(.bottom, 16)
                
                Text("Bio")
                TextField("Enter your bio", text: .constant(""))
                    .padding(.bottom, 16)
                
                Text("Country")
                TextField("Enter your country", text: .constant(""))
            }
            .padding(.leading)
            
        }
        .padding(.bottom, 300)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}

