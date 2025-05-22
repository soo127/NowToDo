//
//  SheetType.swift
//  NowToDo
//
//  Created by 이상수 on 5/14/25.
//

import SwiftUI

enum SheetType: Identifiable {

    case alarm(UUID)
    case dueDate(UUID)
    case detail(UUID)

    var id: UUID {
        switch self {
        case .alarm(let id), .dueDate(let id), .detail(let id):
            return id
        }
    }

}
