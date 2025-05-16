//
//  DoneCellView.swift
//  NowToDo
//
//  Created by 이상수 on 5/14/25.
//

import SwiftUI

struct DoneCellView: View {

    var completedItems: [ToDoItem]
    var action: (DoneCellViewAction) -> Void

    var body: some View {

        NavigationStack {

            VStack {
                ScrollView {
                    VStack {
                        ForEach(completedItems) { item in
                            DoneCell(
                                text: item.text,
                                completedAt: item.completedAt,
                                onClick: { action(.onClick(item.id)) }
                            )
                        }
                    }
                }
                .padding(.top, 10)

                Button("삭제") {
                    action(.onRemove)
                }
            }
            .navigationTitle(Text("완료된 항목"))
            .toolbar {
                Button {
                    action(.onDismiss)
                } label: {
                    Image(systemName: "xmark")
                }
            }

        }

    }

}

#Preview {
    DoneCellView(completedItems: [], action: {_ in })
}
