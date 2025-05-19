//
//  ToDoCell.swift
//  NowToDo
//
//  Created by 이상수 on 5/9/25.
//

import SwiftUI

struct ToDoCell: View {

    @Binding var text: String
    @State private var clicked: Bool = false
    let dueDate: Date?
    var clickAction: () -> Void

    var body: some View {

        HStack(alignment: .top) {

            CheckButton(clicked: $clicked, action: clickAction)

            Text("") // spacer for height alignment
                .frame(height: 40)

            ZStack(alignment: .topTrailing) {

                TextField("할 일 추가", text: $text, axis: .vertical)
                    .foregroundStyle(clicked ? .gray : .primary)
                    .padding(.trailing, 40) // 오른쪽 공간 확보

                if let dDay = dDay(), let color = dateColor() {
                    Text("D\(color == .red ? "+" : "-")\(abs(dDay))")
                        .foregroundStyle(color)
                        .padding(.top, 8)
                        .padding(.trailing, 4)
                }

            }

        }
        .listRowSeparator(.visible)

    }

    private var today: Date {
        Calendar.current.startOfDay(for: Date())
    }
    private var now: Date {
        Date()
    }

    private func dDay() -> Int? {
        guard let dueDate = dueDate else { return nil }

        let components = Calendar.current.dateComponents([.day], from: now, to: dueDate)
        return components.day
    }

    private func dateColor() -> Color? {
        guard let dueDate = dueDate else { return nil }

        if now > dueDate {
            return .red
        } else if Calendar.current.isDate(now, inSameDayAs: dueDate) {
            return .orange
        } else {
            return .green
        }
    }

}
