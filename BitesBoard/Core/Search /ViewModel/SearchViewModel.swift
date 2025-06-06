//
//  SearchViewModel.swift
//  BitesBoard
//
//  Created by lai shanice on 7/6/25.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    
    init(){
        Task{
            try await fetchAllUsers()
        }
    }
    
    @MainActor
    func fetchAllUsers() async throws {
        self.users = try await UserService.fetchAllUsers()
    }
}
