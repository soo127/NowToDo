//
//  MenuView.swift
//  NowToDo
//
//  Created by 이상수 on 5/14/25.
//

import SwiftUI

struct MenuView: View {

    @Binding var alignMode: AlignMode
    var onAction: (MenuAction) -> Void

    var body: some View {

        Menu {

            Button("완료된 항목 보기") {
                onAction(.showCompleted)
            }

            Menu("정렬") {

                Button {
                    onAction(.alignByCreationDate)
                } label: {
                    HStack {
                        Text("먼저 추가한 순")
                        if alignMode == .creationDate {
                            Spacer()
                            Image(systemName: "checkmark")
                        }
                    }
                }

                Button {
                    onAction(.alignByDueDate)
                } label: {
                    HStack {
                        Text("마감이 빠른 순")
                        if alignMode == .dueDate {
                            Spacer()
                            Image(systemName: "checkmark")
                        }
                    }
                }

            }

        } label: {
            Image(systemName: "ellipsis.circle")
        }

    }

}

#Preview {
    MenuView(alignMode: .constant(.creationDate), onAction: {_ in })
}
