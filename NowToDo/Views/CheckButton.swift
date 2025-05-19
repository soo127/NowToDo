//
//  ToDoCell.CheckButton.swift
//  NowToDo
//
//  Created by 이상수 on 5/11/25.
//

import SwiftUI

struct CheckButton: View {

    @Binding var clicked: Bool
    var action: () -> Void

    var body: some View {

        Button {
            clicked.toggle()
            action()
        } label: {
            Circle()
                .fill(.white)
                .frame(width: 28, height: 28)
                .overlay(
                    Circle().stroke(clicked ? .orange : .gray, lineWidth: 2)
                )
                .overlay(
                    Group {
                        if clicked {
                            Circle()
                                .fill(.orange)
                                .frame(width: 22, height: 22)
                        }
                    }
                )

        }
        .buttonStyle(PlainButtonStyle())

    }

}



