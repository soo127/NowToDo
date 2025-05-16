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

                ToDoCellView(
                    items: $viewModel.items,
                    onClick: { id in
                        viewModel.toggleCompletion(for: id)
                    }
                )
                FooterView()
                    .onTapGesture {
                        viewModel.append()
                    }

            }
            .navigationTitle(Text("미리 알림"))
            .toolbar {
                MenuView(alignMode: $viewModel.alignMode) {
                    action in viewModel.handle(action: action)
                }
            }

        }
        .fullScreenCover(isPresented: $viewModel.showCompleted) {
            DoneCellView(completedItems: viewModel.completedItems) {
                action in viewModel.handle(action : action)
            }

        }
    }

}

#Preview {
    ContentView()
}
