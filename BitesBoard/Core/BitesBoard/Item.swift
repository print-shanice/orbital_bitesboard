//
//  Item.swift
//  BitesBoard
//
//  Created by lai shanice on 30/5/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
