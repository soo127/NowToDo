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

    var body: some View {

        ScrollView {
            VStack {
                ForEach($items) { item in
                    ToDoCell(
                        text: item.text,
                        dueDate: item.dueDate,
                        clickAction: {
                            onClick(item.id)
                            //viewModel.toggleCompletion(for: item.id)
                        }
                    )
                }
            }
        }
        .padding(.top, 10)

    }

}

#Preview {
    ToDoCellView(items: .constant([]), onClick: {_ in })
}


//                ScrollView {
//                    VStack {
//                        ForEach($viewModel.items) { item in
//                            ToDoCell(
//                                text: item.text,
//                                dueDate: item.dueDate,
//                                clickAction: {
//                                    viewModel.toggleCompletion(for: item.id)
//                                }
//                            )
//                        }
//                    }
//                }
//                .padding(.top, 10)
