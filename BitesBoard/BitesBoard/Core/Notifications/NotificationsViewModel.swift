//
//  NotificationsViewModel.swift
//  BitesBoard
//
//  Created by lai shanice on 20/6/25.
//
import Foundation

@MainActor
class NotificationsViewModel: ObservableObject {
    @Published var notifications: [Notification] = []
    @Published var fromUsers: [String: User] = [:]
    
    init(user: User){
        Task{
            try await loadNotifications(uid: user.id)
        }
    }

    func loadNotifications(uid: String) async throws{
            let fetchedNotifications = try await NotificationService.fetchNotifications(uid: uid)
            self.notifications = fetchedNotifications

        for notification in self.notifications{
            let fromUID = notification.fromUserId
            if fromUsers[fromUID] == nil {
                let user = try await UserService.fetchUserWithUID(withUID: fromUID)
                fromUsers[fromUID] = user
            }
        }
        
    }

}
