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
    let clickAction: () -> Void

    var body: some View {
        HStack(alignment: .top) {
            CheckButton(clicked: $clicked, action: clickAction)

            // 기본 구분선의 왼쪽 여백을 주기 위해 추가함
            Text("")
                .frame(height: 40)

            ZStack(alignment: .topTrailing) {
                todoTextField
                dDayText
            }
        }
        .listRowSeparator(.visible)
    }

    private var todoTextField: some View {
        TextField("할 일 추가", text: $text, axis: .vertical)
            .foregroundStyle(clicked ? .gray : .primary)
            .padding(.trailing, 40)
    }

    @ViewBuilder
    private var dDayText: some View {
        if let dDay = dDay(), let color = dateColor() {
            Text("D\(color == .red ? "+" : "-")\(abs(dDay))")
                .foregroundStyle(color)
                .padding(.top, 8)
                .padding(.trailing, 4)
        }
    }

    private func dDay() -> Int? {
        guard let dueDate = dueDate else {
            return nil
        }

        let calendar = Calendar.current
        let start = calendar.startOfDay(for: now)
        let end = calendar.startOfDay(for: dueDate)

        let components = calendar.dateComponents([.day], from: start, to: end)
        return components.day
    }

    private func dateColor() -> Color? {
        guard let dueDate = dueDate else {
            return nil
        }

        let timeInterval = dueDate.timeIntervalSince(now)
        let hoursRemaining = timeInterval / 3600

        if now > dueDate {
            return .red
        } else if hoursRemaining < 24 {
            return .orange
        } else {
            return .green
        }
    }

    private var now: Date {
        Date()
    }

}
