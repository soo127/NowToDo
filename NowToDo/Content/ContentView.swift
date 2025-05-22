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

            VStack {

                ToDoContainer(
                    items: $viewModel.items,
                    alertType: $viewModel.alertType,
                    sheetType: $viewModel.sheetType,
                    action: viewModel.handle
                )
                FooterView()
                    .onTapGesture {
                        viewModel.append()
                    }

            }
            .navigationTitle(Text("미리 알림"))
            .toolbar {
                MenuView(alignMode: $viewModel.alignMode, action: viewModel.handle)
            }

        }
        .fullScreenCover(item: $viewModel.historyType) { type in
            HistoryContainer(type: type, items: viewModel.items(type: type)) {
                act in viewModel.handle(type: type, action: act)
            }
        }
        

    }

}

#Preview {
    ContentView()
}
