//
//  FooterView.swift
//  NowToDo
//
//  Created by 이상수 on 5/11/25.
//

import SwiftUI

struct FooterView: View {

    var body: some View {
        HStack {
            Circle()
                .fill(.orange)
                .frame(width: 30, height: 30)
                .overlay {
                    Image(systemName: "plus")
                        .foregroundStyle(.white)
                }

            Text("새로운 미리 알림")
                .foregroundStyle(.orange)
                .fontWeight(.semibold)
            Spacer()
        }
        .padding()
    }
    
}

#Preview {
    FooterView()
}
