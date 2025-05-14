//
//  ContentView.swift
//  NowToDo
//
//  Created by 이상수 on 5/9/25.

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = ContentViewModel()

    var body: some View {

        NavigationStack {

            ScrollView {
                ForEach($viewModel.items) { item in
                    ToDoCell(
                        text: item.text,
                        dueDate: item.dueDate,
                        clickAction: {
                            viewModel.toggleRemoval(for: item.id)
                        }
                    )
                }
            }
            .navigationTitle(Text("미리 알림"))
            .padding(.top, 10)
            .navigationBarItems(trailing:
                MenuView(alignMode: $viewModel.alignMode) {
                    action in viewModel.handleMenu(onAction: action)
                }
            )

            FooterView()
                .onTapGesture {
                    viewModel.append()
                }

        }
    }

}

#Preview {
    ContentView()
}
