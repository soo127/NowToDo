//
//  NowToDoApp.swift
//  NowToDo
//
//  Created by 이상수 on 5/9/25.
//

import SwiftUI
import UserNotifications

@main
struct NowToDoApp: App {

    init() {

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, _ in }


        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.orange]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
}
