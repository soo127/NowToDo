//
//  AlarmSheet.swift
//  NowToDo
//
//  Created by 이상수 on 5/18/25.
//

import SwiftUI

struct AlarmSheet: View {

    @State var alarmDate: Date?
    let onComplete: (Date) -> Void
    let cancel: () -> Void

    var body: some View {

        VStack {
            Text("언제 알림을 받을까요?")
                .font(.headline)
                .padding()
            datePicker

            Spacer()

            Button("설정 완료") {
                onComplete(alarmDate ?? Date())
            }

            Spacer()

            Button("알림 지우기") {
                cancel()
            }

            Spacer()
        }
        .presentationDetents([.medium])

    }

    private var datePicker: some View {
        DatePicker(
            "알림일",
            selection: Binding<Date>(
                get: { alarmDate ?? Date() },
                set: { alarmDate = $0 }
            ),
            in: Date()...,
            displayedComponents: [.date, .hourAndMinute]
        )
        .labelsHidden()
    }

}
