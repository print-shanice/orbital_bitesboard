//
//  TabView.swift
//  BitesBoard
//
//  Created by lai shanice on 4/6/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Text("Feed")
                .tabItem {
                    Image(systemName: "house")
                }
            
            Text("Search")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            Text("NewPost")
                .tabItem {
                    Image(systemName: "plus.square")
                }
        
            
            Text("Notifications")
                .tabItem {
                    Image(systemName: "bell")
                }
            
            ProfileView()
                .tabItem{
                    Image(systemName:"person.circle")
                }
        }
        .accentColor(.black)
    }
}

struct MainTabView_Preview: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
