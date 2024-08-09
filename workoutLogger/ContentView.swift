//
//  ContentView.swift
//  workoutLogger
//
//  Created by Shania Kohli on 7/20/24.
//

import SwiftUI

struct ContentView: View {
    let gridItems = [
        GridItem(.fixed(150)),
        GridItem(.fixed(150))
    ]
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var workoutManager: WorkoutManager
    @EnvironmentObject var goalsManager: GoalsManager

    var body: some View {
        NavigationStack {
            VStack {
                Text("Fitness Tracker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Spacer()
                LazyVGrid(columns: gridItems, spacing: 20) {
                    NavigationLink(destination: LogWorkoutView()) {
                        VStack {
                            Text("Log Workout")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Image(systemName: "pencil.circle")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding(5)
                        }
                        .frame(width: 150, height: 150)
                        .background(Color.blue)
                        .cornerRadius(15)
                    }

                    NavigationLink(destination: SetGoals()) {
                        VStack {
                            Text("Set Goals")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Image(systemName: "target")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding(5)
                        }
                        .frame(width: 150, height: 150)
                        .background(Color.green)
                        .cornerRadius(15)
                    }

                    NavigationLink(destination: TrackProgress()) {
                        VStack {
                            Text("Track Progress")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(5)
                            Image(systemName: "chart.bar")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        }
                        .frame(width: 150, height: 150)
                        .background(Color.red)
                        .cornerRadius(15)
                    }

                    NavigationLink(destination: WorkoutHistory()) {
                        VStack {
                            Text("Workout History")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(5)
                            Image(systemName: "list.bullet")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        }
                        .frame(width: 150, height: 150)
                        .background(Color.purple)
                        .cornerRadius(15)
                    }
                }
                .padding(.horizontal)

                Spacer()

                NavigationLink(destination: ProfileView()) {
                    VStack {
                        Image(systemName: "person.crop.circle")
                            .foregroundColor(.white)
                            .font(.title)
                    }
                    .frame(width: 80, height: 50)
                    .background(Color.yellow)
                    .cornerRadius(5)
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserData())
            .environmentObject(WorkoutManager())
            .environmentObject(GoalsManager())
    }
}
