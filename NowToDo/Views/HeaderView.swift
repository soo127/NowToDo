//
//  HeaderView.swift
//  NowToDo
//
//  Created by 이상수 on 5/11/25.
//

import SwiftUI

enum SortMode {
    case creationDate
    case dueDate
}

struct HeaderView: View {

    @State var isShowAlert: Bool = false
    @Binding var sortMode: SortMode

    var body: some View {
        HStack {
            Text("미리 알림")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.orange)
            Spacer()
            Button("정렬") {
                isShowAlert.toggle()
            }
            .alert("정렬 방식 선택", isPresented: $isShowAlert) {
                Button("\(sortMode == .creationDate ? "✓ " : "")먼저 추가한 일부터 (기본)") {
                    sortMode = .creationDate
                }
                Button("\(sortMode == .dueDate ? "✓ " : "")마감이 빠른 일부터") {
                    sortMode = .dueDate
                }
            }
        }
        .padding()
    }

}
