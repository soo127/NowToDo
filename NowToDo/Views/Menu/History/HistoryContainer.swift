//
//  HistoryContainer.swift
//  NowToDo
//
//  Created by 이상수 on 5/21/25.
//

import SwiftUI

struct HistoryContainer: View {

    let type: HistoryType
    let items: [ToDoItem]
    let action: (HistoryContainerAction) -> Void
    var body: some View {

        switch type {
        case .alarmed:
            AlarmedContainer(items: items, action: action)
        case .done:
            DoneContainer(items: items, action: action)
        }

    }
}
