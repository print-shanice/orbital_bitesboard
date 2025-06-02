//
//  BitesBoardApp.swift
//  BitesBoard
//
//  Created by lai shanice on 30/5/25.
//

// BitesBoardApp.swift
import SwiftUI
import SwiftData
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

@main
struct BitesBoardApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    @StateObject var viewModel = AuthViewModel()
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
       WindowGroup {
            NavigationStack {
                LogInView()
           }
            .environmentObject(viewModel)
        }
}


}
