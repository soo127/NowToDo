//
//  AlarmedCell.swift
//  NowToDo
//
//  Created by 이상수 on 5/21/25.
//

import SwiftUI

struct AlarmedCell: View {

    @State private var clicked: Bool = false
    var text: String
    var alarmedDate: Date
    var onClick: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                CheckButton(clicked: $clicked, action: onClick)
                
                Text(text)
                    .foregroundStyle(.gray)
                
                Spacer()
                
                Text(alarmedDate.formatted())
                    .foregroundStyle(.gray)
            }
            .padding(.vertical, 5)
            Divider()
        }
        .padding(.horizontal)
    }

}

#Preview {
    AlarmedCell(text: "울린 알림", alarmedDate: Date(), onClick: {})
}


