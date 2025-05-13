//
//  ToDoItem.swift
//  NowToDo
//
//  Created by 이상수 on 5/9/25.
//

import SwiftUI

struct ToDoItem: Identifiable, Codable {

    var id = UUID()
    var text: String = ""
    var dueDate: Date?
    var createdAt = Date()

}

extension ToDoItem {
    
    static var empty: ToDoItem {
        ToDoItem()
    }

}
