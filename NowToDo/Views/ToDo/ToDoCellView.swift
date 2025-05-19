//
//  ToDoCellView.swift
//  NowToDo
//
//  Created by 이상수 on 5/15/25.
// TODO: - 알람이 있을 때는 며칠 뒤 알람인지 알려줄 수 있으면 좋음.
// TODO: - 단순히 dayAfter만 있으면, 끝나는 날짜를 가늠할 수 없음. >> 그냥 AlarmPickerView도 DatePicker로 바꿔서 해결하기, ToDoItem에는 alarmDate로 바꾸기.

import SwiftUI

struct ToDoCellView: View {

    @Binding var items: [ToDoItem]
    @State private var showAlert: Bool = false
    @State private var sheetType: SheetType? = nil
    var action: (ToDoCellViewAction) -> Void

    var body: some View {
        List {
            ForEach($items) { item in
                ToDoCell(
                    text: item.text,
                    dueDate: item.dueDate.wrappedValue,
                    clickAction: { action(.onClick(item.id)) }
                )
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {

                    // 삭제
                    Button(role: .destructive) {
                        action(.remove(item.id))
                    } label: {
                        Image(systemName: "trash")
                    }

                    // 푸시 알림
                    let dayAfter = item.dayAfter.wrappedValue
                    Button {
                        if dayAfter > 0 {
                            action(.cancel(item.id))
                        } else {
                            sheetType = .alarm(item.id)
                        }
                    } label: {
                        dayAfter > 0 ? Image(systemName: "bell.and.waves.left.and.right") : Image(systemName: "bell.slash")
                    }
                    .tint(.blue)

                    // 기한 추가
                    let dueDate = item.dueDate.wrappedValue
                    Button {
                        if dueDate == nil {
                            sheetType = .dueDate(item.id)
                        } else {
                            action(.removeDueDate(item.id))
                        }
                    } label: {
                        Image(systemName: "calendar")
                    }
                    .tint(dueDate == nil ? .gray : .green)

                }
            }
        }
        .alert("해당 ToDo는 마감 이후 울리는 알람이 존재합니다.\n확인해주세요.", isPresented: $showAlert) {
            Button("확인", role: .cancel) { }
        }
        .sheet(item: $sheetType) { sheet in

            switch sheet {

            case .alarm(let id):
                AlarmPickerView { dayAfter in
                    tryNotification(for: id, dayAfter: dayAfter)
                }
            case .dueDate(let id):
                DueDatePickerView { dueDate in
                    trySetDueDate(for: id, dueDate: dueDate)
                }

            }
        }
        .listStyle(.plain)
    }

    private func trySetDueDate(for id: UUID, dueDate: Date) {
        if let index = items.firstIndex(where: { $0.id == id }) {
            items[index].dueDate = dueDate
        }
        // TODO: - 해당 ToDo는 마감 이후 울리는 알람이 존재합니다.\n확인해주세요 조건 달기.
        sheetType = nil
    }

    private func tryNotification(for id: UUID, dayAfter: Int){
        guard let index = items.firstIndex(where: { $0.id == id }) else { return }
        guard let alarmDate = Calendar.current.date(byAdding: .day, value: dayAfter, to: Date()) else { return }

        if let dueDate = items[index].dueDate, alarmDate > dueDate  {
            showAlert = true
        } else {
            action(.notify(index, dayAfter))
        }
        sheetType = nil
    }

}
