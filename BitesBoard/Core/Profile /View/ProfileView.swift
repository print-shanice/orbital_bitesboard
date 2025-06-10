//
//  ProfileView.swift
//  BitesBoard
//
//  Created by lai shanice on 4/6/25.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    let user: User
    @StateObject var viewModel: CurrentUserProfileViewModel
    
    init(user: User){
        self.user = user
        self._viewModel = StateObject(wrappedValue: CurrentUserProfileViewModel(user: user))
    }
    
    var body: some View {
            VStack{
                //header
                VStack{
                    //pfp
                    HStack {
                        Spacer()
                        CircularProfileImageView(user: user, size: .large)
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    
                    
                    // followers, following and username
                    HStack(spacing: 20){
                        if user.isCurrentUser {
                            NavigationLink(destination: FollowersView()) {
                                UserStatView(value: 10, title: "Followers")
                            }
                        } else {
                            Button (action: {}){
                                label: do {
                            }
                                Text("Follow")
                            }
                        }
                        
                        Text("@\(user.username ?? "")")
                            .font(.footnote)
                            .fontWeight(.bold)
                        
                        if user.isCurrentUser {
                            NavigationLink(destination: FollowingView()) {
                                UserStatView(value: 10, title: "Following")
                            }
                        } else {
                            Button (action: {}){
                                label: do {
                            }
                                Text("Following")
                            }
                        }
                    }
                    .padding(.horizontal)
                    Divider()
                }
                
                //your favourite bites
                VStack(alignment: .leading) {
                    Text("Favourite Bites")
                        .padding(.horizontal)
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(viewModel.reviews) { review in
                                KFImage(URL(string: review.foodPhoto))
                                    .resizable()
                                    .frame(width:200, height:200)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                //your recent activity
                VStack(alignment: .leading) {
                    Text("Recent Activity")
                        .padding(.horizontal)
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(viewModel.reviews) { review in
                                KFImage(URL(string: review.foodPhoto))
                                    .resizable()
                                    .frame(width:200, height:200)
                                    .cornerRadius(10)
                                
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
}


struct ProfileView_Previews : PreviewProvider {
    static var previews: some View {
        ProfileView(user: User.MOCK_USERS[0])
    }
}
