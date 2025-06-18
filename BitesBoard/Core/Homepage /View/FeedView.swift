//
//  Untitled.swift
//  BitesBoard
//
//  Created by lai shanice on 4/6/25.
//


import SwiftUI

struct FeedView: View {
    let user: User
    var column: HomepageColumn
    @StateObject var viewModel: FeedViewModel
    
    init(user: User, column: HomepageColumn) {
        self.user = user
        self.column = column
        self._viewModel = StateObject(wrappedValue: FeedViewModel(user: user))
    }
    
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVStack(spacing: 32) {
                    ForEach(viewModel.reviews){ post in
                        FeedCell(user: user, review: post, viewModel: viewModel)
                    }
                }
            }
            .padding(.vertical)
            .onChange(of: column) {
                Task {
                    try? await viewModel.fetchPosts(for: column)
                }
            }
        }
    }
}
    
//struct FeedView_Previews: PreviewProvider {
//        static var previews: some View {
//            FeedView()
//        }
//}

