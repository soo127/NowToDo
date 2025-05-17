//
//  ToDoCellView.swift
//  NowToDo
//
//  Created by 이상수 on 5/15/25.

import SwiftUI

struct ToDoCellView: View {

    @Binding var items: [ToDoItem]
    @State var showAlert: Bool = false
    @State var dayBefore: Int = 1
    @State var selectedItem: ToDoItem? = nil
    var action: (ToDoCellViewAction) -> Void

    var body: some View {

        List {
            ForEach($items) { item in

                ToDoCell(
                    text: item.text,
                    dueDate: item.dueDate,
                    clickAction: { action(.onClick(item.id)) }
                )
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {

                    Button(role: .destructive) {
                        action(.remove(item.id))
                    } label: {
                        Image(systemName: "trash")
                    }

                    Button {
                        guard let _ = item.wrappedValue.dueDate else {
                            showAlert = true
                            return
                        }
                        selectedItem = item.wrappedValue
                    } label: {
                        VStack {
                            Image(systemName: "bell")
                            Text("마감 \(dayBefore)일 전 알람")
                        }
                    }
                    .tint(.blue)
                }

            }
            .listRowSeparator(.hidden)
        }
        .alert("마감일이 없습니다.\n일정을 먼저 설정해주세요.", isPresented: $showAlert) {
            Button("확인", role: .cancel) { }
        }
        .sheet(item: $selectedItem) { item in
            AlarmPickerView(dayBefore: $dayBefore) {
                action(.notify(item, dayBefore))
                selectedItem = nil
            }
        }
        .listStyle(.plain)
    }

}

#Preview {
    ToDoCellView(items: .constant([]), action: { _ in })
}
