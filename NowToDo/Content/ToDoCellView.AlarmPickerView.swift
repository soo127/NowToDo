//
//  ToDoCellView.AlarmPickerView.swift
//  NowToDo
//
//  Created by 이상수 on 5/18/25.
//

import SwiftUI

extension ToDoCellView {

    struct AlarmPickerView: View {

        @State private var dayAfter: Int = 1
        var onComplete: (Int) -> Void

        var body: some View {
            VStack {
                Text("며칠 후에 알림을 받을까요?")
                    .font(.headline)
                    .padding()

                Picker("알림 시점", selection: $dayAfter) {
                    ForEach(1...30, id: \.self) { day in
                        Text("\(day)일 후").tag(day)
                    }
                }
                .pickerStyle(.wheel)
                .frame(maxHeight: 150)

                Button("완료") {
                    onComplete(dayAfter)
                }
                .padding()
            }
            .presentationDetents([.medium])
        }
    }

}
