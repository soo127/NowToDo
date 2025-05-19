//
//  ToDoCell.DateButton.swift
//  NowToDo
//
//  Created by 이상수 on 5/12/25.
//

import SwiftUI

extension ToDoCellView {
    
    struct DueDatePickerView: View {

        @State private var dueDate: Date = Date()
        var onComplete: (Date) -> Void

        var body: some View {

            VStack {

                Text("마감 기한을 \(dueDate.formatted())로 설정할게요.")
                    .font(.headline)
                    .padding()

                DatePicker(
                    "마감일",
                    selection: $dueDate,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .labelsHidden()

                Button("완료") {
                    onComplete(dueDate)
                }

            }
            .presentationDetents([.medium])
        }

    }

}
