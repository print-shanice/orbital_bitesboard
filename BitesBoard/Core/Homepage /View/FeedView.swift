//
//  Untitled.swift
//  BitesBoard
//
//  Created by lai shanice on 4/6/25.
//


import SwiftUI

struct FeedView: View {
    @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 32) {
                ForEach(viewModel.reviews){ post in
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

