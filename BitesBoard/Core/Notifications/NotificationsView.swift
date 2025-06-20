//
//  NotificationsView.swift
//  BitesBoard
//
//  Created by lai shanice on 10/6/25.
//

import SwiftUI
import Kingfisher

struct NotificationsView: View {
    let user: User
    @StateObject var viewModel: NotificationsViewModel
    
    init(user: User) {
        self.user = user
        self._viewModel =  StateObject(wrappedValue: NotificationsViewModel(user: user))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Notifications")
                    .foregroundStyle(.red)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.notifications) { notification in
                        if let fromUser = viewModel.fromUsers[notification.fromUserId] {
                            NavigationLink(value: fromUser){
                                NotificationsRowView(notification: notification)
                            }
                        }
                    }
                }
                .padding(.top, 20)
            }
            .navigationDestination(for: User.self, destination: { targetUser in
                ProfileView(currUser: user, targetUser: targetUser)
            })
        }
        
        
    }
}

struct NotificationsRowView: View {
    let notification: Notification

    @State private var fromUser: User?
    @State private var review: Review?

    var body: some View {
        HStack {
            if let fromUser = fromUser {
                CircularProfileImageView(user: fromUser, size: .small)
                
                HStack(spacing: 4) {
                    Text("\(fromUser.username ?? "" )")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Text("\(notification.type == "follow" ? "followed you" : "liked your review")")
                        .font(.subheadline)
                }
                
            } else {
                ProgressView()
                Text("Loading user...")
                    .font(.subheadline)
            }

            Spacer()
            
            if notification.type == "like", let review = review {
                KFImage(URL(string: review.foodPhoto))
                    .resizable()
                    .frame(width: 40, height: 40)
                    .cornerRadius(10)
            }
            Spacer()
            
            Text(RelativeDateTimeFormatter()
                .localizedString(for: notification.timestamp.dateValue(), relativeTo: Date()))
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
        .task {
            fromUser = try? await UserService.fetchUserWithUID(withUID: notification.fromUserId)
            
            if let reviewId = notification.reviewId, !reviewId.isEmpty {
                print("Trying to fetch review with ID: \(reviewId)")
                review = try? await ReviewService.fetchReview(reviewId: reviewId)
            }
        }
    }

}


struct NotificationsView_Previews: PreviewProvider {
    
    static var previews: some View {
        NotificationsView(user: User.MOCK_USERS[0])
    }
}


