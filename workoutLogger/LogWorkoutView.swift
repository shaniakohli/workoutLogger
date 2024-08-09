//
//  LogWorkoutView.swift
//  workoutLogger
//
//  Created by Shania Kohli on 7/20/24.
//

import Foundation
import SwiftUI

struct LogWorkoutView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @State private var workoutName: String = ""
    @State private var exerciseName: String = ""
    @State private var sets: String = ""
    @State private var reps: String = ""
    @State private var exercises: [Workout.Exercise] = []

    var body: some View {
        VStack(spacing: 20) {
            // Workout Name
            TextField("Workout Name", text: $workoutName)
                .padding()
                .background(Color.blue.opacity(0.1)) // Light blue background for differentiation
                .cornerRadius(15)
                .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(Color.blue, lineWidth: 2)) // Blue border
                .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: 5)
            
            TextField("Exercise Name", text: $exerciseName)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 5)
            
            TextField("Sets", text: $sets)
                .keyboardType(.numberPad)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 5)
            
            TextField("Reps", text: $reps)
                .keyboardType(.numberPad)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 5)
            
            Button(action: {
                if let setCount = Int(sets), let repCount = Int(reps), !exerciseName.isEmpty {
                    let exercise = Workout.Exercise(name: exerciseName, sets: setCount, reps: repCount)
                    exercises.append(exercise)
                    exerciseName = ""
                    sets = ""
                    reps = ""
                }
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add Exercise")
                }
                .font(.headline)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 5)
            }
            
            List(exercises, id: \.name) { exercise in
                VStack(alignment: .leading) {
                    Text(exercise.name)
                        .font(.headline)
                    Text("Sets: \(exercise.sets), Reps: \(exercise.reps)")
                        .font(.subheadline)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.1), radius: 5, x: 0, y: 2)
            }
            
            Button(action: {
                let workout = Workout(name: workoutName, exercises: exercises)
                workoutManager.addWorkout(workout)
                workoutName = ""
                exercises = []
            }) {
                HStack {
                    Image(systemName: "square.and.arrow.down.fill")
                    Text("Save Workout")
                }
                .font(.headline)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 5)
            }
        }
        .padding()
        .navigationBarTitle("Log Workout", displayMode: .inline)
    }
}

struct LogWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogWorkoutView()
            .environmentObject(WorkoutManager())
    }
}
