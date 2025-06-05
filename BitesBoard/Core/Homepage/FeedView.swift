//
//  Untitled.swift
//  BitesBoard
//
//  Created by lai shanice on 4/6/25.
//

import SwiftUI

struct FeedView: View {
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 32) {
                ForEach(Review.MOCK_REVIEWS){ post in
                    FeedCell(review: post)
                }
            }
        }
        .padding(.vertical)
    }
}
    
struct FeedView_Previews: PreviewProvider {
        static var previews: some View {
            FeedView()
        }
}

