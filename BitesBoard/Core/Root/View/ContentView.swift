//
//  ContentView.swift
//  BitesBoard
//
//  Created by lai shanice on 30/5/25.
//
//
import SwiftUI


struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @StateObject var registrationViewModel = RegistrationViewModel()
    var body: some View {
        Group {
           if viewModel.userSession == nil {
               NavigationStack {
                   LogInView()
               }
               .environmentObject(registrationViewModel)
           } else if let currentUser = viewModel.currentUser{
               NavigationStack {
                   MainTabView(user: currentUser)
               }
           }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
