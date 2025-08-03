//
//  Item.swift
//  GGToDo
//
//  Created by Gerard Grundy on 3/8/2025.
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
