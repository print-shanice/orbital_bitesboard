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
                    
                    // username and location
                    HStack {
                        if user.isCurrentUser {
                            NavigationLink(destination: FollowersView()) {
                                Text("Followers")
                                    .font(.subheadline)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.gray.opacity(0.5))
                                    .cornerRadius(8)

                            }
                        } else {
                            Button(action: {}) {
                                Text("Follow")
                                    .font(.subheadline)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .foregroundStyle(.red)
                            }
                        }
                        Spacer()

                        VStack(spacing: 4) {
                            Text("@\(user.username ?? "")")
                                .font(.footnote)
                                .fontWeight(.semibold)

                            HStack(spacing: 4) {
                                Image(systemName: "mappin.and.ellipse")
                                    .foregroundColor(.gray)
                                Text(user.country ?? "earth")
                                    .font(.caption)
                            }
                        }
                        Spacer()
                        
                        if user.isCurrentUser {
                            NavigationLink(destination: FollowingView()) {
                                Text("Following")
                                    .font(.subheadline)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.gray.opacity(0.5))
                                    .cornerRadius(8)
                            }
                        } else {
                            Button(action: {}) {
                                Text("Following")
                                    .font(.subheadline)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                    .padding(.horizontal)

                    
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
