//
//  DoneCell.swift
//  NowToDo
//
//  Created by 이상수 on 5/14/25.
//

import SwiftUI

struct DoneCell: View {

    var text: String
    var dueDate: Date?
    var completedAt: Date?
    @State private var clicked: Bool = false

    var onClick: () -> Void

    var body: some View {

        VStack(alignment: .leading) {

            HStack(alignment: .top) {

                CheckButton(clicked: $clicked, action: onClick)
                    .frame(width: 24, height: 24)


                Text(text)
                    .foregroundStyle(.gray)

                Spacer()

                Text(completedAt!.formatted())
                    .foregroundStyle(.gray)

            }
            .padding(.vertical, 5)

            Divider()

        }
        .padding(.horizontal)

    }

}

#Preview {
    DoneCell(text: "완료", dueDate: Date(), completedAt: Date(), onClick: {})
}


