//
//  NotificationService.swift
//  BitesBoard
//
//  Created by lai shanice on 20/6/25.
//
import Firebase
import FirebaseFirestore

struct NotificationService {
    
    static func uploadNotification(uid : String, toUserId: String, type: String, reviewId: String? = nil) async throws {
        guard uid != toUserId else { return }

        let data: [String: Any] = [
            "type": type,
            "fromUserId": uid,
            "reviewId": reviewId ?? "",
            "timestamp": Timestamp()
        ]

        try await Firestore.firestore().collection("users").document(toUserId).collection("notifications").addDocument(data: data)
    }
    

    static func fetchNotifications(uid: String) async throws -> [Notification] {
        let snapshot = try await Firestore.firestore().collection("users").document(uid).collection("notifications").order(by: "timestamp", descending: true).getDocuments()

        return try snapshot.documents.compactMap {
            try $0.data(as: Notification.self)
        }
    }
}

