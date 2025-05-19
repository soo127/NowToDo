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
    case notify(Int, Int)
    case cancel(UUID)
    case removeDueDate(UUID)

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

enum SheetType: Identifiable {

    case alarm(UUID)
    case dueDate(UUID)
    var id: UUID {
        switch self {
        case .alarm(let id), .dueDate(let id):
            return id
        }
    }

}
