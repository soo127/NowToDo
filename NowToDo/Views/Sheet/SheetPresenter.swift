//
//  SheetPresenter.swift
//  NowToDo
//
//  Created by 이상수 on 5/20/25.
//

import SwiftUI

struct SheetPresenter: View {

    let sheetType: SheetType
    let items: [ToDoItem]
    let action: (ToDoContainerAction) -> Void

    var body: some View {
        switch sheetType {

        case .detail(let id):
            DetailSheet(alarmDate: alarmDate(id), dueDate: dueDate(id))
        case .dueDate(let id):
            DueDateSheet(dueDate: dueDate(id)) { dueDate in
                action(.setDueDate(id, dueDate))
            } cancel: {
                action(.removeDueDate(id))
            }
        case .alarm(let id):
            AlarmSheet(alarmDate: alarmDate(id)) { alarmDate in
                action(.notify(id, alarmDate))
            } cancel: {
                action(.cancelAlarm(id))
            }

        }
    }

    private func alarmDate(_ id: UUID) -> Date? {
        return items.first(where: { $0.id == id })?.alarmDate
    }

    private func dueDate(_ id: UUID) -> Date? {
        return items.first(where: { $0.id == id })?.dueDate
    }
    
}
