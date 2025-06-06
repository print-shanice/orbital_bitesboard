//
//  SearchView.swift
//  BitesBoard
//
//  Created by lai shanice on 4/6/25.
//
// currently only implemented searching for users
import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""
    @StateObject var viewModel = SearchViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.users){ user in
                        NavigationLink(value:user){
                            HStack {
                                if user.profilePicture != nil {
                                    Image(user.profilePicture ?? "")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 40, height:40)
                                        .clipShape(Circle())
                                } else {
                                    Image(systemName:"person.circle")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 40, height:40)
                                        .clipShape(Circle())
                                        .foregroundStyle(.gray)
                                    
                                }
                                
                                VStack(alignment: .leading){
                                    Text(user.username)
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
                }
                .padding(.top, 8)
                .searchable(text: $searchText, prompt: "Search...")
            }
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
            })
            .navigationTitle("Explore users")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
