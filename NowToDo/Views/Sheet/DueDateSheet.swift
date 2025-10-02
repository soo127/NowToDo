//
//  DueDateSheet.swift
//  NowToDo
//
//  Created by 이상수 on 5/12/25.
//

import SwiftUI

struct DueDateSheet: View {

    @State var dueDate: Date?
    let onComplete: (Date) -> Void
    let cancel: () -> Void
    
    var body: some View {
        VStack {
            Text("마감 기한을 \(dueDate?.formatted() ?? Date().formatted())로 설정할게요.")
                .font(.headline)
                .padding()
            datePicker

            Spacer()

            Button("설정 완료") {
                onComplete(dueDate ?? Date())
            }

            Spacer()

            Button("기한 지우기") {
                cancel()
            }

            Spacer()
        }
        .presentationDetents([.medium])
    }

    private var datePicker: some View {
        DatePicker(
            "마감일",
            selection: Binding<Date>(
                get: { dueDate ?? Date() },
                set: { dueDate = $0 }
            ),
            displayedComponents: [.date, .hourAndMinute]
        )
        .labelsHidden()
    }

}
