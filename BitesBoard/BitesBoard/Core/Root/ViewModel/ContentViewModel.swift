//
//  ContentViewModel.swift
//  BitesBoard
//
//  Created by lai shanice on 6/6/25.
//

import Foundation
import FirebaseAuth
import Firebase
import Combine

@MainActor
class ContentViewModel: ObservableObject {
    private let service = AuthService.shared
    private var cancellables = Set<AnyCancellable>()
    @Published var userSession : FirebaseAuth.User?
    @Published var currentUser : User?
    
    init(){
        setUserSession( )
    }
    func setUserSession(){
        service.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        
        }
        .store(in: &cancellables)
        
        service.$currentUser.sink { [weak self] currentUser in
            self?.currentUser = currentUser
        
        }
        .store(in: &cancellables)
    }
}
