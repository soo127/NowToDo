//
//  ToDoCellView.AlarmPickerView.swift
//  NowToDo
//
//  Created by 이상수 on 5/18/25.
//

import SwiftUI

extension ToDoCellView {

    struct AlarmPickerView: View {

        @Binding var dayBefore: Int
        var action: () -> Void

        var body: some View {
            VStack {
                Text("마감 며칠 전에 알람을 받을까요?")
                    .font(.headline)
                    .padding()

                Picker("알람 시점", selection: $dayBefore) {
                    ForEach(1...30, id: \.self) { day in
                        Text("\(day)일 전").tag(day)
                    }
                }
                .pickerStyle(.wheel)
                .frame(maxHeight: 150)

                Button("완료") {
                    action()
                }
                .padding()
            }
            .presentationDetents([.medium])
        }
    }

}
