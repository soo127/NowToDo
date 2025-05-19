//
//  ToDoCell.DateButton.swift
//  NowToDo
//
//  Created by 이상수 on 5/12/25.
//

import SwiftUI

extension ToDoCell {

    struct DueDatePicker: View {

        @Binding var dueDate: Date?
        private var today: Date {
            Calendar.current.startOfDay(for: Date())
        }
        private var dueDay: Date {
            return Calendar.current.startOfDay(for: dueDate ?? Date())
        }

        var body: some View {

            VStack(alignment: .trailing) {

                if dueDate != nil {

                    Text(dDay() >= 0 ? "D-\(dDay())" : "D+\(abs(dDay()))")
                        .foregroundStyle(dateColor())

                    DatePicker(
                        "",
                        selection: Binding(
                            get: { dueDate ?? Date() },
                            set: { dueDate = $0 }
                        ),
                        displayedComponents: [.date]
                    )

                } else {

                    Spacer()

                    Button("일정 추가") {
                        dueDate = today
                    }
                    .foregroundStyle(.blue)
                    .buttonStyle(PlainButtonStyle())
                }

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
