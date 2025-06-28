//
//  BookmarkView.swift
//  BitesBoard
//
//  Created by lai shanice on 7/6/25.
//
import SwiftUI

struct BookmarkView: View {
    let user: User
    @StateObject var viewModel: FeedViewModel
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: FeedViewModel(user: user, column: .bookmarks))
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 32) {
                ForEach(viewModel.reviews){ post in
                    FeedCell(user: user, review: post, viewModel: viewModel)
                }
            }
        }
        .padding(.vertical)
    }
}
