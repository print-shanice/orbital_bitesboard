//
//  Untitled.swift
//  BitesBoard
//
//  Created by lai shanice on 4/6/25.
//

import SwiftUI

struct FeedView: View {
    @State private var currentColumn: FeedCategory = .forYou
    @Namespace private var animationNameSpace
    @StateObject private var dataStore = ReviewsDataStore()
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    ForEach(FeedCategory.allCases){ category in
                        Button(action: {
                            currentColumn = category
                        }){
                            VStack(spacing:6){
                                Text(category.rawValue)
                                    .font(.subheadline)
                                    .fontWeight(currentColumn == category ? .bold : .regular)
                                    .foregroundStyle(currentColumn == category ? .red : .gray)
                                //underlining currentCol
                                if currentColumn == category{
                                    Rectangle()
                                        .frame(height:2)
                                        .foregroundStyle(.red)
                                        .matchedGeometryEffect(id: "underline", in: animationNameSpace)
                                } else {
                                    Rectangle()
                                        .frame(height:2)
                                        .foregroundStyle(.clear)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .animation(.spring(), value: currentColumn)
                .background(Color.white)
                .padding(.horizontal)
                .padding(.bottom, 8)
                Divider()

                ScrollView {
                    LazyVStack(spacing: 32) {
                        ForEach(postsForSelectedCategory()){ post in
                            FeedCell(review: post, onReviewUpdate : { updatedReviewID, updatedIsLiked, updatedLikesCount, updatedIsBookmarked in
                                dataStore.updateReview(id: updatedReviewID, isLiked: updatedIsLiked, likesCount: updatedLikesCount, isBookmarked: updatedIsBookmarked)
                            })
                        }
                    }
                }
                .padding(.vertical)
            }
        }
    }
    
    private func postsForSelectedCategory() -> [Review] {
        return dataStore.allReviews.filter { review in
            review.categories.contains(currentColumn)
        }
    }
}
struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
