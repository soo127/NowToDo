//
//  ToDoItem.swift
//  NowToDo
//
//  Created by 이상수 on 5/9/25.
//

import SwiftUI

struct ToDoItem: Identifiable, Codable {

    let id: UUID
    let createdDate: Date
    var dueDate: Date?
    var doneDate: Date?
    var alarmDate: Date?
    var text: String

    init() {
        self.id = UUID()
        self.createdDate = Date()
        self.dueDate = nil
        self.doneDate = nil
        self.alarmDate = nil
        self.text = ""
    }

}

extension ToDoItem {
    
    static var empty: ToDoItem {
        ToDoItem()
    }

}
