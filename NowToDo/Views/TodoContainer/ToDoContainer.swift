//
//  ToDoContainer.swift
//  NowToDo
//
//  Created by 이상수 on 5/15/25.

import SwiftUI

struct ToDoContainer: View {

    @Binding var items: [ToDoItem]
    //@Binding var showAlert: Bool
    @Binding var alertType: AlertType?
    @Binding var sheetType: SheetType?
    //@Binding var showNotificationAlert: Bool
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

//        .alert("해당 ToDo는 마감 이후 알람이 울립니다.", isPresented: $showAlert) {
//            Button("확인", role: .cancel) { }
//        }
//        .alert("과거에 알림을 설정할 수 없습니다.", isPresented: $impossibleAlarm) {
//            Button("확인", role: .cancel) { }
//        }
//        .alert("설정에서 알림 권한을 허용해주세요.", isPresented: $showNotificationAlert) {
//            Button("확인", role: .cancel) { }
//        }
        .onAppear {
            action(.moveExpiredAlarms)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            action(.moveExpiredAlarms)
        }
    }

}
