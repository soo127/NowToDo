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
    var clickAction: () -> Void

    var body: some View {

        HStack(alignment: .top) {

            CheckButton(clicked: $clicked, action: clickAction)
                .buttonStyle(PlainButtonStyle())

            VStack {

                HStack(alignment: .top) {
                    TextField("할 일 추가", text: $text, axis: .vertical)
                        .foregroundStyle(clicked ? .gray : .primary)

                    DueDatePicker(
                        dueDate: $dueDate
                    )
                }
                Divider()
                    .padding(.top, 5)

            }

        }

    }

}

#Preview {
    List {
        ToDoCell(text: .constant("테스트"), dueDate: .constant(Date()), clickAction: {})
            .listRowSeparator(.hidden)
        ToDoCell(text: .constant("테스트"), dueDate: .constant(Date()), clickAction: {})
            .listRowSeparator(.hidden)
        ToDoCell(text: .constant("테스트"), dueDate: .constant(Date()), clickAction: {})
            .listRowSeparator(.hidden)
    }
    
    .listStyle(.plain)

}

#Preview {
    ToDoCell(text: .constant("테스트"), dueDate: .constant(nil), clickAction: {})
}
