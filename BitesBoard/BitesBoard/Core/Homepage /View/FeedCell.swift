//
//  FeedCell.swift
//  BitesBoard
//
//  Created by lai shanice on 4/6/25.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    let user: User
    let review : Review
    @ObservedObject var viewModel: FeedViewModel
    
    @State private var isLiked: Bool = false
        @State private var isBookmarked: Bool = false
        @State private var likesCount: Int = 0
    
    var body: some View {
        VStack(spacing: 10){
        //pfp, username and restaraunt
            VStack(spacing: 2) {
                HStack{
                    if let owner = review.user {
                        CircularProfileImageView(user: owner, size: .small)
                        
                        NavigationLink(destination: ProfileView(currUser: user, targetUser: owner)) {
                            Text(owner.username ?? "")
                                .font(.footnote)
                                .foregroundStyle(.black)
                                .fontWeight(.bold)
                        }
                    }
                    
                    Text("at")
                        .font(.footnote)
                    Text(review.restaurantName)
                        .font(.footnote)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    ViewDietaryTagsView(selectedTags: review.dietaryTags ?? [])
                        .padding(.trailing, 40)

                    
                }
                .padding(.bottom, 10)
                HStack{
                    HStack {
                        Text("\(review.cuisine ?? "")  |")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                        
                        Text("$\(review.price)")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                        
                        Spacer()
                    }
                    
                    Text(RelativeDateTimeFormatter()
                        .localizedString(for: review.timestamp.dateValue(), relativeTo: Date()))
                    .font(.footnote)
                    .foregroundColor(.gray)
                    
                    Spacer()
                }
                .padding(.trailing)
            }
            .padding(.leading)
            
            
        //food photo
            ZStack(alignment: .bottomLeading){
                KFImage(URL(string: review.foodPhoto))
                    .resizable()
                    .clipShape(Rectangle())
                    .scaledToFill()
                    .allowsHitTesting(false)
                    .frame(height: 250)
                    .cornerRadius(10)
                    .overlay(alignment: .topTrailing){
                        Button(action: {
                            isBookmarked.toggle()
                            Task {
                                if isBookmarked {
                                    try await viewModel.bookmarkReview(reviewId: review.id)
                                } else {
                                    try await viewModel.unbookmarkReview(reviewId: review.id)
                                }
                            }
                        }){
                            Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                                .resizable()
                                .frame(width: 30, height: 40)
                                .foregroundStyle(.white.opacity(1))
                        }
                        .padding(.horizontal,10)
                        .padding(.vertical, 10)
                    }
                StarRatingView(rating: review.starRating)
                    .font(.largeTitle)
                    .padding(.bottom, 10)
                    .padding(.leading, 10)
            }
            .padding(.horizontal)
        //caption and likes
            VStack{
                
                HStack {
                    Text(review.caption)
                        .font(.subheadline)
                    Spacer()
                }
                .padding(.leading)
                
                HStack {
                    Button(action: {
                        isLiked.toggle()
                        likesCount += isLiked ? 1 : -1
                        
                        Task {
                            if isLiked {
                                try await viewModel.likeReview(reviewId: review.id)
                                
                                if review.ownerId != user.id {
                                    try await NotificationService.uploadNotification(uid: user.id, toUserId: review.ownerId, type: "like", reviewId: review.id)
                                }
                            } else {
                                try await viewModel.unlikeReview(reviewId: review.id)
                            }
                        }
                    }){
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundStyle(isLiked ? .red : .gray)
                    }
                    Text("\(likesCount) likes")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.leading)
            }
        }
        .onAppear {
            isLiked = review.favouritedBy?.contains(user.id) ?? false
            isBookmarked = review.bookmarkedBy?.contains(user.id) ?? false
            likesCount = review.favouritedBy?.count ?? 0
        }
    }
}


struct FeedCell_Previews : PreviewProvider {
    static var previews: some View {
        FeedCell(user: User.MOCK_USERS[0], review: Review.MOCK_REVIEWS[0], viewModel: FeedViewModel(user: User.MOCK_USERS[0]))
    }
}




