//
//  CellActions.swift
//  NowToDo
//
//  Created by 이상수 on 5/19/25.
//

import SwiftUI

enum HistoryContainerAction {

    case dismiss
    case remove
    case click(UUID)

}

enum ToDoContainerAction {

    case click(UUID)
    case remove(UUID)
    case notify(UUID, Date)
    case setDueDate(UUID, Date)
    case cancelAlarm(UUID)
    case removeDueDate(UUID)
    case moveExpiredAlarms

}
