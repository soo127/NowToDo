//
//  NowToDoApp.swift
//  NowToDo
//
//  Created by 이상수 on 5/9/25.
//

import SwiftUI

@main
struct NowToDoApp: App {

    init() {
      // Large Navigation Title
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.orange]
      // Inline Navigation Title
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
}
