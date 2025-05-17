//
//  ToDoCellView.swift
//  NowToDo
//
//  Created by 이상수 on 5/15/25.
//

import SwiftUI

struct ToDoCellView: View {

    @Binding var items: [ToDoItem]
    var onClick: (UUID) -> Void
    var remove: (UUID) -> Void
    var body: some View {

        List {
            ForEach($items) { item in
                ToDoCell(
                    text: item.text,
                    dueDate: item.dueDate,
                    clickAction: {
                        onClick(item.id)
                    }
                )
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        remove(item.id)
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
            .listRowSeparator(.hidden)

        }
        .listStyle(.plain)
    }

}

#Preview {
    ToDoCellView(items: .constant([]), onClick: { _ in }, remove: { _ in })
}
