//
//  WorkoutHistory.swift
//  workoutLogger
//
//  Created by Shania Kohli on 7/21/24.
//

import Foundation
import SwiftUI

struct WorkoutHistory: View {
    @EnvironmentObject var workoutManager: WorkoutManager

    var body: some View {
        VStack {
            Text("Workout History")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)

            List {
                ForEach(workoutManager.workouts) { workout in
                    NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                        VStack(alignment: .leading) {
                            Text(workout.name)
                                .font(.headline)
                            Text("Exercises: \(workout.exercises.count)")
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: deleteWorkout)
            }
        }
        .navigationBarTitle("Workout History", displayMode: .inline)
        .padding()
    }

    private func deleteWorkout(at offsets: IndexSet) {
        offsets.forEach { index in
            workoutManager.workouts.remove(at: index)
        }
        workoutManager.saveWorkouts()
    }
}

struct WorkoutDetailView: View {
    let workout: Workout
    
    var body: some View {
        VStack {
            Text(workout.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            List(workout.exercises) { exercise in
                VStack(alignment: .leading) {
                    Text(exercise.name)
                        .font(.headline)
                    Text("Sets: \(exercise.sets), Reps: \(exercise.reps)")
                        .font(.subheadline)
                }
            }
        }
        .navigationBarTitle("Workout Details", displayMode: .inline)
        .padding()
    }
}

struct WorkoutHistoryPreview: PreviewProvider {
    static var previews: some View {
        WorkoutHistory()
            .environmentObject(WorkoutManager())
    }
}
