//
//  Login.swift
//  workoutLogger
//
//  Created by Shania Kohli on 7/21/24.
//
import SwiftUI

struct Login: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var workoutManager: WorkoutManager
    @EnvironmentObject var goalsManager: GoalsManager
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showError: Bool = false
    @State private var navigateToWelcome: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome to Fitness Tracker")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.bottom, 40)
                    .multilineTextAlignment(.center)

                Spacer()

                VStack(spacing: 20) {
                    TextField("Enter Your Name Here", text: $userData.name)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .multilineTextAlignment(.center)

                    TextField("Enter a Username Here", text: $username)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .multilineTextAlignment(.center)

                    SecureField("Enter Your Password Here", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .multilineTextAlignment(.center)
                }
                if showError {
                    Text("Please fill out all fields before continuing")
                        .foregroundColor(.red)
                        .padding()
                }
                Spacer()
                Button(action: {
                    if checkFields() {
                        showError = false
                        navigateToWelcome = true
                    } else {
                        showError = true
                    }
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                .padding(.top, 20)
            }
            .padding(.horizontal, 20)
            .navigationDestination(isPresented: $navigateToWelcome) {
                WelcomeView()
                    .environmentObject(userData)
                    .environmentObject(workoutManager)
                    .environmentObject(goalsManager)
            }
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }

    func checkFields() -> Bool {
        return !(userData.name.isEmpty || username.isEmpty || password.isEmpty)
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
            .environmentObject(UserData())
            .environmentObject(WorkoutManager())
            .environmentObject(GoalsManager())
    }
}
