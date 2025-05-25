//
//  ToDoContainer.swift
//  NowToDo
//
//  Created by 이상수 on 5/15/25.

import SwiftUI

struct ToDoContainer: View {

    @Binding var items: [ToDoItem]
    @Binding var alertType: AlertType?
    @Binding var sheetType: SheetType?
    let action: (ToDoContainerAction) -> Void
    
    var body: some View {
        List {
            ForEach($items) { $item in
                ToDoCell(
                    text: $item.text,
                    dueDate: item.dueDate,
                    clickAction: { action(.click(item.id)) }
                )
                .swipeActions(edge: .leading, allowsFullSwipe: false) {
                    DetailButton(sheetType: $sheetType, item: item)
                }
                .swipeActions(edge: .trailing) {
                    DeleteButton(id: item.id, action: action)
                    AlarmButton(sheetType: $sheetType, item: item, action: action)
                    DateButton(sheetType: $sheetType, item: item, action: action)
                }
            }
        }
        .listStyle(.plain)
        .sheet(item: $sheetType) { sheetType in
            SheetPresenter(sheetType: sheetType, items: items, action: action)
        }
        .alert(item: $alertType) { type in
            Alert(title: Text(type.message), dismissButton: .default(Text("확인")))
        }
        .onAppear {
            action(.moveExpiredAlarms)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            action(.moveExpiredAlarms)
        }
    }

}
