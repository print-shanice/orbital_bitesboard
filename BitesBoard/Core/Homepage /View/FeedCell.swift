//
//  FeedCell.swift
//  BitesBoard
//
//  Created by lai shanice on 4/6/25.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    let review : Review
    @State var isBookmarked : Bool = false
    @State var isLiked : Bool = false
    @State private var likesCount : Int = 0
    
    
    init(review:Review) {
        self.review = review
        self._isBookmarked = State(initialValue: review.isBookmarked)
        self._isLiked = State(initialValue: review.isLiked)
        self._likesCount = State(initialValue: review.likesCount)
    }
    
    var body: some View {
        VStack(spacing: 10){
        //pfp, username and restaraunt
            VStack(spacing: 2) {
                HStack{
                    if let user = review.user {
                        CircularProfileImageView(user: user, size: .small)
                        
                        Text(review.user?.username ?? "")
                            .font(.footnote)
                            .fontWeight(.bold)
                    }
                    
                    Text("at")
                        .font(.footnote)
                    Text(review.restaurantName)
                        .font(.footnote)
                        .fontWeight(.bold)
                    Spacer()
                }
                
                HStack{
                    Text(RelativeDateTimeFormatter()
                        .localizedString(for: review.timestamp.dateValue(), relativeTo: Date()))
                    .font(.footnote)
                    .foregroundColor(.gray)
                    
                    Spacer()
                }
            }
            .padding(.leading)
            
            
        //food photo
            ZStack(alignment: .bottomLeading){
                KFImage(URL(string: review.foodPhoto))
                    .resizable()
                    .clipShape(Rectangle())
                    .scaledToFill()
                    .frame(height: 250)
                    .cornerRadius(10)
                    .overlay(alignment: .topTrailing){
                        Button(action: {
                            print("hi")
                            isBookmarked.toggle()
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
                        print("hi")
                        isLiked.toggle()
                        if isLiked {
                            likesCount += 1
                        } else {
                            likesCount -= 1
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
    }
}


struct FeedCell_Previews : PreviewProvider {
    static var previews: some View {
        FeedCell(review: Review.MOCK_REVIEWS[0])
    }
}




