//
//  ContentView.swift
//  NowToDo
//
//  Created by 이상수 on 5/9/25.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = ContentViewModel()

    var body: some View {

        VStack {

            ScrollView {
                HeaderView()
                VStack {
                    ForEach($viewModel.items) { item in
                        ToDoCell(
                            text: item.text,
                            dueDate: item.date,
                            clickAction: {
                                viewModel.toggleRemoval(for: item.id)
                            }
                        )
                    }
                }
            }

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
