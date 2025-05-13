//
//  ToDoCell.swift
//  NowToDo
//
//  Created by 이상수 on 5/9/25.
//

import SwiftUI

struct ToDoCell: View {

    @Binding var text: String
    @Binding var dueDate: Date?
    @State private var clicked: Bool = false
    @State var showDate: Bool = false
    var clickAction: () -> Void

    var body: some View {

        VStack {

            HStack(alignment: .top) {
                CheckButton(clicked: $clicked, action: clickAction)

                TextField("할 일 추가", text: $text, axis: .vertical)
                    .foregroundStyle(clicked ? .gray : .primary)

                DueDatePicker(
                    dueDate: $dueDate
                )
            }
            .padding(.vertical, 5)

            Divider()
        }
        .padding(.horizontal)

    }

}

#Preview {
    ToDoCell(text: .constant("테스트"), dueDate: .constant(Date()), clickAction: {})
}
