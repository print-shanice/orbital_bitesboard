//
//  HomepageBarView.swift
//  BitesBoard
//
//  Created by lai shanice on 9/6/25.

import SwiftUI

enum HomepageColumn: String, CaseIterable {
    case following = "Following"
    case friends = "Friends"
    case forYou = "For you"
    case favourites = "Favourites"
}

struct HomepageBarView: View {
    let user: User
    @State var selectedColumn: HomepageColumn = .forYou
    @StateObject private var viewModel: FeedViewModel
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: FeedViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(HomepageColumn.allCases, id: \.self) { column in
                    Button(action: {
                        selectedColumn = column
                    }) {
                        VStack {
                            Text(column.rawValue)
                                .fontWeight(selectedColumn == column ? .bold : .regular)
                                .foregroundColor(selectedColumn == column ? .red : .gray)
                            if selectedColumn == column {
                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundColor(.red)
                            } else {
                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundColor(.clear)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            FeedView(user: user, column: selectedColumn)
        }
    }
}

struct HomepageBarView_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var selectedColumn: HomepageColumn = .following
            
        var body: some View {
            HomepageBarView(user: User.MOCK_USERS[0])
        }
    }

    static var previews: some View {
        PreviewWrapper()
    }
}
