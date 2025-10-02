//
//  MenuView.swift
//  NowToDo
//
//  Created by 이상수 on 5/14/25.
//

import SwiftUI

struct MenuView: View {

    @Binding var alignMode: AlignMode
    let action: (MenuType) -> Void

    var body: some View {
        Menu {
            Button("울린 알림 보기") {
                action(.showSoundedAlarms)
            }

            Button("완료된 항목 보기") {
                action(.showDoneCells)
            }

            Menu("정렬") {
                creationDateButton
                dueDateButton
            }
        } label: {
            Image(systemName: "ellipsis.circle")
        }
    }

    private var creationDateButton: some View {
        Button {
            action(.alignByCreationDate)
        } label: {
            HStack {
                Text("먼저 추가한 순")
                if alignMode == .creationDate {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }

    private var dueDateButton: some View {
        Button {
            action(.alignByDueDate)
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

}

#Preview {
    MenuView(alignMode: .constant(.creationDate), action: {_ in })
}
