//
//  TrackProgress.swift
//  workoutLogger
//
//  Created by Shania Kohli on 7/20/24.
//

import Foundation
import SwiftUI
import HealthKit

struct TrackProgress: View {
    @State private var workouts: [HKWorkout] = []
    @State private var steps: [HKQuantitySample] = []
    @State private var distances: [HKQuantitySample] = []
    @State private var heartRates: [HKQuantitySample] = []
    @State private var error: Error?

    var body: some View {
        VStack {
            Text("Track Progress")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
            Spacer()

            if let error = error {
                Text("Error: \(error.localizedDescription)")
                    .foregroundColor(.red)
            } else {
                List {
                    Section(header: Text("Workouts")) {
                        ForEach(workouts, id: \.uuid) { workout in
                            VStack(alignment: .leading) {
                                Text("Type: \(workout.workoutActivityType.rawValue)")
                                Text("Duration: \(workout.duration.formatted(.number.precision(.fractionLength(2)))) minutes")
                            }
                        }
                    }

                    Section(header: Text("Steps")) {
                        ForEach(steps, id: \.uuid) { sample in
                            Text("Steps: \(sample.quantity.doubleValue(for: HKUnit.count()))")
                        }
                    }

                    Section(header: Text("Distances")) {
                        ForEach(distances, id: \.uuid) { sample in
                            Text("Distance: \(sample.quantity.doubleValue(for: HKUnit.meter())) meters")
                        }
                    }

                    Section(header: Text("Heart Rates")) {
                        ForEach(heartRates, id: \.uuid) { sample in
                            Text("Heart Rate: \(sample.quantity.doubleValue(for: HKUnit(from: "count/min")))) BPM")
                        }
                    }
                }
            }

            Spacer()
        }
        .navigationBarTitle("Track Progress", displayMode: .inline)
        .padding()
        .onAppear {
            HealthKitManager.shared.requestAuthorization { success, error in
                if success {
                    HealthKitManager.shared.fetchWorkouts { workouts, error in
                        if let workouts = workouts {
                            self.workouts = workouts
                        } else {
                            self.error = error
                        }
                    }
                    
                    HealthKitManager.shared.fetchSteps { steps, error in
                        if let steps = steps {
                            self.steps = steps
                        } else {
                            self.error = error
                        }
                    }

                    HealthKitManager.shared.fetchDistances { distances, error in
                        if let distances = distances {
                            self.distances = distances
                        } else {
                            self.error = error
                        }
                    }

                    HealthKitManager.shared.fetchHeartRates { heartRates, error in
                        if let heartRates = heartRates {
                            self.heartRates = heartRates
                        } else {
                            self.error = error
                        }
                    }
                } else {
                    self.error = error
                }
            }
        }
    }
}


