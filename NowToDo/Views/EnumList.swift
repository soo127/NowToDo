//
//  EnumList.swift
//  NowToDo
//
//  Created by 이상수 on 5/14/25.
//

import SwiftUI

enum DoneCellViewAction {

    case onDismiss
    case onRemove
    case onClick(UUID)

}

enum MenuAction {

    case alignByCreationDate
    case alignByDueDate
    case delete
    case alarm
    case showCompleted

}

enum AlignMode {

    case creationDate
    case dueDate

}
