//
//  DeleteReviewsView.swift
//  BitesBoard
//
//  Created by lai shanice on 25/6/25.
//
import SwiftUI


struct DeleteReviewsView: View {
    let user: User
    @State private var showAlert: Bool = false
    @State private var selectedReview: Review? = nil
    @StateObject var viewModel: DeleteReviewsViewModel
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: DeleteReviewsViewModel(user: user))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Delete Your Reviews")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
                .padding(.top)
                .padding(.leading, 75)
                .padding(.bottom, 20)
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.userReviews) { review in
                        VStack(spacing: 8) {
                            FeedCell(user: user, review: review, viewModel: FeedViewModel(user: user))
                                .padding(.bottom, 4)
                            
                            //delete button below
                            Button(role: .destructive) {
                                selectedReview = review
                                showAlert = true
                            } label: {
                                Label("Delete", systemImage: "trash")
                                    .font(.subheadline)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .background(Color.gray.opacity(0.1))
                                    .foregroundColor(.red)
                                    .cornerRadius(10)
                            }
                            
                        }
                        .padding()
                        .background(Color.gray.opacity(0.05))
                        .cornerRadius(10)
                    }
                }
                .padding(.bottom)
            }
        }
        .alert("Confirm deletion?", isPresented: $showAlert, presenting: selectedReview) { review in
                    Button("Delete", role: .destructive) {
                        Task {
                            try await viewModel.deleteReviewWithId(reviewId: review.id)
                        }
                    }
                    Button("Cancel", role: .cancel) {}
                } message: { _ in
                    Text("Click Delete to confirm")
                }
    }
}

struct DeleteReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteReviewsView(user: User.MOCK_USERS[0])
    }
}
