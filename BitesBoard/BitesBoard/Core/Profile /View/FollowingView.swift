//
//  FollowingView.swift
//  BitesBoard
//
//  Created by lai shanice on 4/6/25.
//

import SwiftUI

struct FollowingView: View {
    let user: User
    @StateObject var viewModel: FollowingViewModel
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: FollowingViewModel(user: user))

    }
    
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVStack(spacing: 12) {
                    Text("Following")
                        .fontWeight(.semibold)
                        .font(.title2)
                        .foregroundStyle(.red)
                    ForEach(viewModel.users){ user in
                        NavigationLink(value:user){
                            HStack {
                                CircularProfileImageView(user: user, size: .small)
                                
                                VStack(alignment: .leading){
                                    Text(user.username ?? "")
                                        .fontWeight(.semibold)
                                    Text(user.bio ?? "")
                                }
                                .font(.footnote)
                                Spacer()
                            }
                            .foregroundStyle(.black)
                            .padding(.horizontal)
                        }
                        .padding(.bottom, 8)
                    }
                }
            }
            .navigationDestination(for: User.self, destination: { selectedUser in
                ProfileView(currUser: user, targetUser: selectedUser)
            })
        }
    }
}
