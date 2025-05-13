//
//  ToDoCell.DateButton.swift
//  NowToDo
//
//  Created by 이상수 on 5/12/25.
//

import SwiftUI

extension ToDoCell {

    struct DueDatePicker: View {

        //@Binding var showDate: Bool
        @Binding var dueDate: Date?
        private var today: Date {
            Calendar.current.startOfDay(for: Date())
        }
        private var dueDay: Date {
            return Calendar.current.startOfDay(for: dueDate ?? Date())
        }

        var body: some View {

            if dueDate != nil {

                VStack(alignment: .trailing) {
                    Text(dDay() >= 0 ? "D-\(dDay())" : "D+\(abs(dDay()))")
                        .foregroundStyle(dateColor())

                    DatePicker("",
                        selection: Binding(
                            get: { dueDate ?? Date() },
                            set: { dueDate = $0 }
                        ),
                        displayedComponents: .date
                    )
                }

            } else {

                    Button("일정 추가") {
                        //showDate = true
                        dueDate = today
                    }
                    .font(.footnote)

            }

        }

        private func dateColor() -> Color {
            if today < dueDay {
                return .green
            } else if today == dueDay {
                return .orange
            } else {
                return .red
            }
        }

        private func dDay() -> Int {
            let components = Calendar.current.dateComponents([.day], from: today, to: dueDay)
            return components.day ?? 0
        }

    }

}
