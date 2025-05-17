//
//  EnumList.swift
//  NowToDo
//
//  Created by 이상수 on 5/14/25.
//

import SwiftUI

enum ToDoCellViewAction {

    case onClick(UUID)
    case remove(UUID)
    case notify(ToDoItem, Int)

}

enum DoneCellViewAction {

    case onDismiss
    case onRemove
    case onClick(UUID)

}

enum MenuAction {

    case alignByCreationDate
    case alignByDueDate
    case showCompleted

}

enum AlignMode {

    case creationDate
    case dueDate

}
