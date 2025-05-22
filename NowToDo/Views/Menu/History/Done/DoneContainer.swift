//
//  DoneContainer.swift
//  NowToDo
//
//  Created by 이상수 on 5/14/25.
//

import SwiftUI

struct DoneContainer: View {

    @State private var deleteConfirm: Bool = false
    let items: [ToDoItem]
    let action: (HistoryContainerAction) -> Void

    var body: some View {

        NavigationStack {

            VStack {
                container
                deleteButton
            }
            .navigationTitle(Text("완료된 항목"))
            .toolbar {
                closeButton
            }

        }

    }

    private var container: some View {
        ScrollView {
            VStack {
                ForEach(items) { item in
                    DoneCell(
                        text: item.text,
                        doneDate: item.doneDate!,
                        onClick: { action(.click(item.id)) }
                    )
                }
            }
        }
        .padding(.top, 10)
    }

    private var deleteButton: some View {
        Button("삭제") {
            deleteConfirm = true
        }
        .alert("정말 삭제하시겠습니까?", isPresented: $deleteConfirm) {
            Button("삭제", role: .destructive) {
                action(.remove)
            }
            Button("취소", role: .cancel) { }
        }
    }

    private var closeButton: some View {
        Button {
            action(.dismiss)
        } label: {
            Image(systemName: "xmark")
        }
    }

}

#Preview {
    DoneContainer(items: [], action: {_ in })
}
