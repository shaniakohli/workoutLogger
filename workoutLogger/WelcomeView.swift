//
//  WelcomeView.swift
//  workoutLogger
//
//  Created by Shania Kohli on 8/6/24.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var workoutManager: WorkoutManager
    @EnvironmentObject var goalsManager: GoalsManager
    @State private var navigateToSurvey: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome \(userData.name)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding()

                Spacer()

                Button(action: {
                    navigateToSurvey = true
                }) {
                    VStack {
                        Text("Please Enter Your Information Here")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                        Image(systemName: "target")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(5)
                    }
                }
                .padding()
            }
            .navigationDestination(isPresented: $navigateToSurvey) {
                Survey()
                    .environmentObject(userData)
                    .environmentObject(workoutManager)
                    .environmentObject(goalsManager)
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environmentObject(UserData())
            .environmentObject(WorkoutManager())
            .environmentObject(GoalsManager())
    }
}
