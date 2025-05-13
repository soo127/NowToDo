//
//  ToDoCell.CheckButton.swift
//  NowToDo
//
//  Created by 이상수 on 5/11/25.
//

import SwiftUI

extension ToDoCell {

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
                    .frame(width: 30, height: 30)
                    .overlay(
                        Circle().stroke(clicked ? .orange : .gray, lineWidth: 2)
                    )
                    .overlay(
                        Group {
                            if clicked {
                                Circle()
                                    .fill(.orange)
                                    .frame(width: 24, height: 24)
                            }
                        }
                    )
            }

        }

    }

}
