//
//  Survey.swift
//  workoutLogger
//
//  Created by Shania Kohli on 7/21/24.
//

import SwiftUI

struct Survey: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var workoutManager: WorkoutManager
    @EnvironmentObject var goalsManager: GoalsManager
    @State var showErrorSurvey: Bool = false
    @State var navigateToThankYou: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("User Survey for \(userData.name)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                Spacer()
                Group {
                    TextField("Enter your gender (male/female)", text: $userData.gender)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Please enter your age", text: $userData.age)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Please enter your height(ex: 62 in)", text: $userData.height)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Please enter your weight(ex: 130 lbs)", text: $userData.weight)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal, 20)
                if showErrorSurvey {
                    Text("Please fill out all fields before continuing")
                        .foregroundColor(.red)
                        .padding()
                }
                Spacer()
                Button(action: {
                    if checkFieldsSurvey() {
                        showErrorSurvey = false
                        navigateToThankYou = true
                    } else {
                        showErrorSurvey = true
                    }
                }){
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                }.padding(.horizontal, 20)
                .navigationDestination(isPresented: $navigateToThankYou) {
                    SurveyThankYou()
                        .environmentObject(userData)
                        .environmentObject(workoutManager)
                        .environmentObject(goalsManager)
                }
                
                Spacer()
            }
            .navigationBarTitle("User Workout History", displayMode: .inline)
            .padding()
    }
func checkFieldsSurvey() -> Bool {
    return !(userData.gender.isEmpty || userData.age.isEmpty || userData.weight.isEmpty || userData.height.isEmpty)
    }
}

struct SurveyPreview: PreviewProvider {
    static var previews: some View {
        Survey()
            .environmentObject(UserData())
            .environmentObject(WorkoutManager())
            .environmentObject(GoalsManager())
    }
}

struct SurveyThankYou: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var workoutManager: WorkoutManager
    @EnvironmentObject var goalsManager: GoalsManager
    var body: some View {
        VStack {
            Text("Thank You")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.top, 40)
                .padding(.bottom, 20)
            
            Spacer()
            
            NavigationLink(destination: ContentView()
                .environmentObject(userData)
                .environmentObject(goalsManager)) {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }
            .padding(.bottom, 40)
            
            Spacer()
        }
        .navigationBarTitle("Survey Completed", displayMode: .inline)
    }
}

struct SurveyThankYouPreview: PreviewProvider{
    static var previews: some View{
        SurveyThankYou()
            .environmentObject(UserData())
            .environmentObject(WorkoutManager())
            .environmentObject(GoalsManager())
    }
}
