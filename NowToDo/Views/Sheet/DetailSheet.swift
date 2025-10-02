//
//  DetailSheet.swift
//  NowToDo
//
//  Created by 이상수 on 5/20/25.
//

import SwiftUI

struct DetailSheet: View {

    let alarmDate: Date?
    let dueDate: Date?

    var body: some View {
        VStack {
            Label(alarmDate?.formatted() ?? "X", systemImage: "bell")
            Label(dueDate?.formatted() ?? "X", systemImage: "calendar")
        }
        .presentationDetents([.medium])
    }

}
