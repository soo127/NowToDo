//
//  HeaderView.swift
//  NowToDo
//
//  Created by 이상수 on 5/11/25.
//

import SwiftUI

struct HeaderView: View {

    var body: some View {
        HStack {
            Text("미리 알림")
                .font(.title)
                .padding(10)
                .fontWeight(.bold)
                .foregroundStyle(.orange)
            Spacer()
            
        }
    }

}
