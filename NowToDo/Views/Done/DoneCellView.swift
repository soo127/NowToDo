//
//  DoneCellView.swift
//  NowToDo
//
//  Created by 이상수 on 5/14/25.
//

import SwiftUI

struct DoneCellView: View {

    @State var deleteConfirm: Bool = false
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
                    deleteConfirm = true
                }
                .alert("정말 삭제하시겠습니까?", isPresented: $deleteConfirm) {
                    Button("삭제", role: .destructive) {
                        action(.onRemove)
                    }
                    Button("취소", role: .cancel) { }
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
