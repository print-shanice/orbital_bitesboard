//
//  CurrentUserProfileView.swift
//  BitesBoard
//
//  Created by lai shanice on 5/6/25.
//

import SwiftUI

struct CurrentUserProfileView: View {
    let user: User
    @State private var showSettings = false
    var body: some View {
        NavigationStack {
            VStack{
                //header
                VStack{
                    //pfp
                    HStack {
                        Spacer()
                        if user.profilePicture != nil {
                            Image(user.profilePicture ?? "profilePicture")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                        } else {
                            Image(systemName:"person.circle")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    
                    
                    // followers, following and username
                    HStack(spacing: 20){
                        NavigationLink(destination: FollowersView()) {
                            UserStatView(value: 10, title: "Followers")
                        }
                        Text("@\(user.username)")
                            .font(.footnote)
                            .fontWeight(.bold)
                        
                        NavigationLink(destination: FollowingView()) {
                            UserStatView(value: 10, title: "Following")
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
                            ForEach(0..<6) { _ in
                                Image("food")
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
                            ForEach(0..<6) { _ in
                                Image("food")
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
