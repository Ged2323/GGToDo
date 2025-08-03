//
//  TaskModel.swift
//  GGToDo
//
//  Created by Gerard Grundy on 3/8/2025.
//

import SwiftData
import Foundation

@Model
class Task {
    var title: String
    var isCompleted: Bool
    var dateCompleted: Date?
    var dueDate: Date?

    init(title: String, isCompleted: Bool = false, dateCompleted: Date? = nil, dueDate: Date? = nil) {
        self.title = title
        self.isCompleted = isCompleted
        self.dateCompleted = dateCompleted
        self.dueDate = dueDate
    }
}
