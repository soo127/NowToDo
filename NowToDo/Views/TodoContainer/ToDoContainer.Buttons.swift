//
//  ToDoContainer.Buttons.swift
//  NowToDo
//
//  Created by 이상수 on 5/19/25.
//

import SwiftUI

extension ToDoContainer {

    struct DetailButton: View {

        @Binding var sheetType: SheetType?
        let item: ToDoItem

        var body: some View {
            Button("세부 사항") {
                sheetType = .detail(item.id)
            }
        }

    }

    struct DeleteButton: View {

        let id: UUID
        let action: (ToDoContainerAction) -> Void

        var body: some View {
            Button(role: .destructive) {
                action(.remove(id))
            } label: {
                Image(systemName: "trash")
            }
        }

    }

    struct AlarmButton: View {

        @Binding var sheetType: SheetType?
        let item: ToDoItem
        let action: (ToDoContainerAction) -> Void

        var body: some View {

            let alarmDate = item.alarmDate
            Button {
                sheetType = .alarm(item.id)
            } label: {
                alarmDate == nil ? Image(systemName: "bell.slash") : Image(systemName: "bell.and.waves.left.and.right")
            }
            .tint(.blue)

        }
    }

    struct DateButton: View {
        
        @Binding var sheetType: SheetType?
        let item: ToDoItem
        let action: (ToDoContainerAction) -> Void

        var body: some View {
            let dueDate = item.dueDate
            Button {
                sheetType = .dueDate(item.id)
            } label: {
                Image(systemName: "calendar")
            }
            .tint(dueDate == nil ? .gray : .green)
        }
        
    }

}
