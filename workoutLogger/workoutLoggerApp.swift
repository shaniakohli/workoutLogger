//
//  workoutLoggerApp.swift
//  workoutLogger
//
//  Created by Shania Kohli on 7/20/24.
//

import SwiftUI

@main
struct workoutLoggerApp: App {
    @StateObject private var userData = UserData()
    @StateObject private var workoutManager = WorkoutManager()
    @StateObject private var goalsManager = GoalsManager()
    var body: some Scene {
        WindowGroup {
            if userData.isLoggedIn {
                ContentView()
                    .environmentObject(userData)
                    .environmentObject(workoutManager)
                    .environmentObject(goalsManager)
            } else {
                Login()
                    .environmentObject(userData)
                    .environmentObject(workoutManager)
                    .environmentObject(goalsManager)
            }
        }
    }
}
