//
//  ContentView.swift
//  NowToDo
//
//  Created by 이상수 on 5/9/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var cellArray: [ToDoItem] = []
    
    var body: some View {
        
        ScrollView {
            
            HStack {
                Text("미리 알림")
                    .font(.title)
                    .padding(10)
                    .fontWeight(.bold)
                    .foregroundStyle(.orange)
                Spacer()
                
            }
            
            VStack {
                
                ForEach($cellArray) { cell in
                    ToDoCell(text: cell.text)
                }
            }
            
        }
        
        HStack {
        
            Button {
                cellArray.append(
                    ToDoItem()
                )
    
            } label: {
                HStack {
                    Circle()
                        .fill(.orange)
                        .frame(width: 30, height: 30)
                        
                    Text("새로운 미리 알림")
                        .foregroundStyle(.orange)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding()
            }
        }
        
    }
}


#Preview {
    ContentView()
}
