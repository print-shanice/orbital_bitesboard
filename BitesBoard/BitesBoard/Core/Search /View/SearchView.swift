//
//  SearchView.swift
//  BitesBoard
//
//  Created by lai shanice on 4/6/25.
//
// currently only implemented searching for users
import SwiftUI

struct SearchView: View {
    let user: User
    @State private var searchText: String = ""
    @StateObject var viewModel = SearchViewModel()
    @State private var filters: ReviewFilters = .default
    
    enum SearchTab: String, CaseIterable {
        case users = "Users"
        case reviews = "Reviews"
    }
    
    // based on search input, check username
    var filteredUsers: [User] {
        if searchText.isEmpty {
            return viewModel.users
        } else {
            return viewModel.users.filter { user in
                (user.username ?? "").localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    //based on search input, check caption and restaraunt
    var filteredReviews: [Review] {
        if searchText.isEmpty {
            return viewModel.reviews
        } else {
            return viewModel.reviews.filter { review in
                review.caption.localizedCaseInsensitiveContains(searchText) ||
                review.restaurantName.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    
    @State private var selectedTab: SearchTab = .users

    var body: some View {
        NavigationStack {
            VStack {
                Picker("Search Mode", selection: $selectedTab) {
                    ForEach(SearchTab.allCases, id: \.self) { tab in
                        Text(tab.rawValue).tag(tab)
                    }
                }
                .pickerStyle(.palette)
                .padding(.horizontal)

                ScrollView {
                    LazyVStack(spacing: 12) {
                        if selectedTab == .users {
                            ForEach(filteredUsers) { user in
                                NavigationLink(value: user) {
                                    HStack {
                                        CircularProfileImageView(user: user, size: .small)
                                        
                                        VStack(alignment: .leading) {
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
                            }
                        } else {
                            ForEach(filteredReviews) { review in
                                FeedCell(user: user, review: review, viewModel: FeedViewModel(user: user))
                                
                            }
                        }
                    }
                    .padding(.top, 8)
                }
                .searchable(text: $searchText, prompt: "Search...")
                .disableAutocorrection(true)
                .autocapitalization(.none)
            }
            .navigationDestination(for: User.self, destination: { targetUser in
                ProfileView(currUser: user, targetUser: targetUser)
            })
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if selectedTab == .reviews {
                        NavigationLink(destination: FilterView(filters: $filters )) {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .onChange(of: filters) { _, newFilters in
                if selectedTab == .reviews {
                    Task {
                        try await viewModel.fetchFilteredReviews(filters: newFilters)
                    }
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(user: User.MOCK_USERS[0])
    }
}
