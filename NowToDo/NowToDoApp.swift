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

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if let error {
                print("ERROR in requesting authorization: \(error)")
            }
        }

        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.orange]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
}
