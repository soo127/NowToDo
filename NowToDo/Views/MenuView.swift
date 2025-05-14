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

            Button("삭제") {
                onAction(.delete)
            }

            Button("알림 설정") {
                onAction(.alarm)
            }

            Menu("정렬") {

                Button {
                    onAction(.alignByCreationDate)
                } label: {
                    Label(
                        "먼저 추가한 순",
                        systemImage: alignMode == .creationDate ? "checkmark" : ""
                    )
                }

                Button {
                    onAction(.alignByDueDate)
                } label: {
                    Label(
                        "마감이 빠른 순",
                        systemImage: alignMode == .dueDate ? "checkmark" : ""
                    )
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
