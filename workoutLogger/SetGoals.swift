//
//  SetGoals.swift
//  workoutLogger
//
//  Created by Shania Kohli on 7/20/24.
//

import Foundation
import SwiftUI

struct SetGoals: View {
    @EnvironmentObject var goalsManager: GoalsManager
    @State private var newGoal: String = ""
    @State private var showAlert: Bool = false
    @State private var progressValues: [UUID: Int] = [:]
    
    var body: some View {
            VStack {
                Text("Set Goals")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                Spacer()
                
                TextField("Enter your goal here", text: $newGoal)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    if newGoal.trimmingCharacters(in: .whitespaces).isEmpty {
                        showAlert = true
                    } else {
                        let goal = Goals(exGoal: newGoal, progress: 0)
                        goalsManager.addGoal(goal)
                        newGoal = ""
                    }
                }) {
                    Text("Add Goal")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Invalid Goal"),
                        message: Text("Please enter a valid goal."),
                        dismissButton: .default(Text("OK"))
                    )
                }
                
                List {
                    ForEach(goalsManager.goals) { goal in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(goal.exGoal)
                                Slider(value: Binding(
                                    get: { Double(progressValues[goal.id] ?? goal.progress) },
                                    set: { newValue in
                                        progressValues[goal.id] = Int(newValue)
                                        goalsManager.updateProgress(for: goal.id, progress: Int(newValue))
                                    }
                                ), in: 0...100, step: 1)
                                Text("Progress: \(goal.progress)%")
                            }
                            Spacer()
                            Button(action: {
                                if let index = goalsManager.goals.firstIndex(where: { $0.id == goal.id }) {
                                    goalsManager.deleteGoal(at: IndexSet(integer: index))
                                }
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .onDelete(perform: goalsManager.deleteGoal)
                }
                
                Spacer()
            }
            .navigationBarTitle("Set Goals", displayMode: .inline)
            .padding()
        }
    }

struct SetGoals_Previews: PreviewProvider {
    static var previews: some View {
        SetGoals()
            .environmentObject(GoalsManager())
    }
}
