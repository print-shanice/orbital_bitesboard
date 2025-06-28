//
//  FollowersView.swift
//  BitesBoard
//
//  Created by lai shanice on 4/6/25.
//

import SwiftUI

struct FollowersView: View {
    let user: User
    @StateObject var viewModel: FollowersViewModel
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: FollowersViewModel(user: user))

    }
    
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVStack(spacing: 12) {
                    Text("Followers")
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
            .navigationDestination(for: User.self, destination: { targetUser in
                ProfileView(currUser: user, targetUser: targetUser)
            })
        }
    }
}

struct FollclearView_Previews: PreviewProvider {
    static var previews: some View {
        FollowersView(user: User.MOCK_USERS[0])
    }
}
