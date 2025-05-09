//
//  ToDoCell.swift
//  NowToDo
//
//  Created by 이상수 on 5/9/25.
//

import SwiftUI

struct ToDoCell: View {
    @Binding var text: String
    @State var btnClicked: Bool = false
    
    var body: some View {
        HStack {
            Button {
                btnClicked.toggle()
                
            } label: {
                Circle()
                    .fill(btnClicked ? .orange : .white)
                    .frame(width: 30, height: 30)
                    .overlay(
                            Circle().stroke(Color.gray, lineWidth: 1)
                        )
            }
            
            TextField("할 일 추가", text: $text)
                .foregroundStyle(btnClicked ? .gray : .primary)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
}

#Preview {
    ToDoCell(text: .constant("테스트"))
}
