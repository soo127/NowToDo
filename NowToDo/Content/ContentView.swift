//
//  ContentView.swift
//  NowToDo
//
//  Created by 이상수 on 5/9/25.
// 일정을 추가했으면 달력이 알아서 해제, 내비게이션 뷰, 알림 

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
    
        VStack {

            HeaderView(sortMode: $viewModel.sortMode)

            ScrollView {
                VStack {
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
