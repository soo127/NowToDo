//
//  DoneCell.swift
//  NowToDo
//
//  Created by 이상수 on 5/14/25.
//

import SwiftUI

struct DoneCell: View {

    @State private var clicked: Bool = false
    var text: String
    var doneDate: Date
    var onClick: () -> Void

    var body: some View {

        VStack(alignment: .leading) {

            HStack(alignment: .top) {

                CheckButton(clicked: $clicked, action: onClick)

                Text(text)
                    .foregroundStyle(.gray)

                Spacer()

                Text(doneDate.formatted())
                    .foregroundStyle(.gray)

            }
            .padding(.vertical, 5)

            Divider()

        }
        .padding(.horizontal)

    }

}

#Preview {
    DoneCell(text: "완료된 항목", doneDate: Date(), onClick: {})
}
