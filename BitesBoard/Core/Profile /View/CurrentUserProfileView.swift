//
//  CurrentUserProfileView.swift
//  BitesBoard
//
//  Created by lai shanice on 5/6/25.
//

import SwiftUI
import Kingfisher

struct CurrentUserProfileView: View {
    let user: User
    @State private var showSettings = false
    @StateObject var viewModel: CurrentUserProfileViewModel
    
    init(user: User){
        self.user = user
        self._viewModel = StateObject(wrappedValue: CurrentUserProfileViewModel(user: user))
    }
    
    var body: some View {
        NavigationStack {
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
                    HStack(spacing: 30){
                        NavigationLink(destination: FollowersView(user: user)) {
                            UserStatView(value: user.followers?.count ?? 0, title: "Followers")
                        }
                        
                        VStack(spacing: 4) {
                            Text("@\(user.username ?? "NA")")
                                .font(.footnote)
                                .fontWeight(.bold)

                            HStack(spacing: 4) {
                                Image(systemName: "mappin.and.ellipse")
                                    .foregroundColor(.gray)
                                Text(user.country ?? "earth")
                                    .font(.caption)
                            }
                        }
                        
                        NavigationLink(destination: FollowingView(user: user)) {
                            UserStatView(value: user.following?.count ?? 0, title: "Following")
                        }
                    }
                    .padding(.horizontal)
                    Divider()
                }
                
                //your favourite bites
                VStack(alignment: .leading) {
                    Text("Your Favourite Bites")
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
                    Text("Your Recent Activity")
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
            .padding(.bottom)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundColor(.black.opacity(0.8))
                    }
                }
            }
            .fullScreenCover(isPresented: $showSettings) {
                SettingsView(user: user)
            }
        }
    }
}

struct CurrentUserProfileView_Preview : PreviewProvider {
    
    static var previews: some View{
        CurrentUserProfileView(user: User.MOCK_USERS[0])
    }
}
