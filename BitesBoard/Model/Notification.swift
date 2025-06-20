//
//  Notification.swift
//  BitesBoard
//
//  Created by lai shanice on 20/6/25.
//
import Foundation
import FirebaseCore
import FirebaseFirestore

struct Notification: Identifiable, Codable, Hashable {
    @DocumentID var id: String?                  
    
    let type: String                     // "follow" or "like"
    let fromUserId: String               // user who did the action (not current user)
    let reviewId: String?
    let timestamp: Timestamp
    
}

