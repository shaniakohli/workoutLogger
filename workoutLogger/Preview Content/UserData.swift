//
//  UserData.swift
//  workoutLogger
//
//  Created by Shania Kohli on 7/22/24.
//

import Foundation
import SwiftUI
import Combine
import HealthKit

class UserData: ObservableObject {
    @Published var name: String {
        didSet {
            UserDefaults.standard.set(name, forKey: "name")
        }
    }
    @Published var gender: String {
        didSet {
            UserDefaults.standard.set(gender, forKey: "gender")
        }
    }
    @Published var age: String {
        didSet {
            UserDefaults.standard.set(age, forKey: "age")
        }
    }
    @Published var height: String {
        didSet {
            UserDefaults.standard.set(height, forKey: "height")
        }
    }
    @Published var weight: String {
        didSet {
            UserDefaults.standard.set(weight, forKey: "weight")
        }
    }
    @Published var isLoggedIn: Bool {
        didSet {
            UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
        }
    }

    init() {
        self.name = UserDefaults.standard.string(forKey: "name") ?? ""
        self.gender = UserDefaults.standard.string(forKey: "gender") ?? ""
        self.age = UserDefaults.standard.string(forKey: "age") ?? ""
        self.height = UserDefaults.standard.string(forKey: "height") ?? ""
        self.weight = UserDefaults.standard.string(forKey: "weight") ?? ""
        self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
}


struct Workout: Codable, Identifiable {
    var id = UUID()
    var name: String
    var exercises: [Exercise]
    
    struct Exercise: Codable, Identifiable{
        var id = UUID()
        var name: String
        var sets: Int
        var reps: Int
    }
}

class WorkoutManager: ObservableObject {
    @Published var workouts: [Workout] = []

    private let key = "workouts"

    init() {
        loadWorkouts()
    }

    func addWorkout(_ workout: Workout) {
        workouts.append(workout)
        saveWorkouts()
    }

    func saveWorkouts() {
        if let data = try? JSONEncoder().encode(workouts) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private func loadWorkouts() {
        if let data = UserDefaults.standard.data(forKey: key),
           let savedWorkouts = try? JSONDecoder().decode([Workout].self, from: data) {
            workouts = savedWorkouts
        }
    }
}

struct Goals: Codable, Identifiable {
    var id = UUID()
    var exGoal: String
    var progress: Int
}

class GoalsManager: ObservableObject {
    @Published var goals: [Goals] = []
    
    func addGoal(_ goal: Goals) {
        goals.append(goal)
        // Save to UserDefaults or other persistent storage if needed
    }
    
    func deleteGoal(at offsets: IndexSet) {
        goals.remove(atOffsets: offsets)
        // Save to UserDefaults or other persistent storage if needed
    }
    
    func updateProgress(for goalID: UUID, progress: Int) {
            if let index = goals.firstIndex(where: { $0.id == goalID }) {
                goals[index].progress = progress
                // Save to UserDefaults or other persistent storage if needed
            }
        }
}


