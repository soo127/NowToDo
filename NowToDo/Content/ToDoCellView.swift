//
//  ToDoCellView.swift
//  NowToDo
//
//  Created by 이상수 on 5/15/25.
// 알람이 있을 때는 며칠 뒤 알람인지 알려줄 수 있으면 좋음.
// 알람 설정할 때 시간 단위도 고려.

import SwiftUI

struct ToDoCellView: View {

    @Binding var items: [ToDoItem]
    @State private var selectedItemID: UUID? = nil
    @State private var isPresented: Bool = false
    @State private var showAlert: Bool = false
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

                    let dayAfter = item.dayAfter.wrappedValue
                    Button {
                        if dayAfter > 0 {
                            action(.cancel(item.id))
                        } else {
                            selectedItemID = item.id
                            isPresented = true
                        }
                    } label: {
                        dayAfter > 0 ? Image(systemName: "bell") : Image(systemName: "bell.slash")
                    }
                    .tint(.blue)

                }
            }
            .listRowSeparator(.hidden)
        }
        .alert("마감일 이후에 알람을 설정할 수 없습니다.", isPresented: $showAlert) {
            Button("확인", role: .cancel) { }
        }
        .sheet(isPresented: $isPresented) {
            AlarmPickerView { dayAfter in
                tryNotification(dayAfter: dayAfter)
            }
        }
        .listStyle(.plain)
    }

    private func tryNotification(dayAfter: Int){
        guard let id = selectedItemID, let index = items.firstIndex(where: { $0.id == id }) else { return }
        guard let alarmDate = Calendar.current.date(byAdding: .day, value: dayAfter, to: Date()) else { return }

        if let dueDate = items[index].dueDate, alarmDate > dueDate  {
            print(alarmDate, dueDate)
            showAlert = true
        } else {
            action(.notify(index, dayAfter))
            isPresented = false
        }
        return
    }

}

#Preview {
    ToDoCellView(items: .constant([]), action: { _ in })
}
