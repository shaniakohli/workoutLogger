//
//  ProfileView.swift
//  workoutLogger
//
//  Created by Shania Kohli on 7/20/24.
//

import Foundation
import SwiftUI
struct ProfileView: View {
    @EnvironmentObject var userData: UserData
    @State private var isEditing: Bool = false
    
    var body: some View {
        VStack {
            Text("Profile")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
            Spacer()
            if isEditing {
                EditProfileView(isEditing: $isEditing)
            } else {
                VStack(alignment: .leading, spacing: 20) {
                    ProfileRow(label: "Name", value: userData.name)
                    ProfileRow(label: "Gender", value: userData.gender)
                    ProfileRow(label: "Age", value: userData.age)
                    ProfileRow(label: "Height", value: userData.height)
                    ProfileRow(label: "Weight", value: userData.weight)
                                }
                .padding(.bottom, 20)
                Spacer()
                Button(action: {
                    isEditing = true
                    }) {
                    VStack {
                        Image(systemName: "pencil")
                            .font(.title)
                            .foregroundColor(.white)
                        Text("Edit")
                            .font(.headline)
                            .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                Spacer()
            }
        }
        .navigationBarTitle("Profile", displayMode: .inline)
        .padding()
    }
}

struct ProfileRow: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 150, alignment: .leading)
            Text(value)
                .font(.body)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.green)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct EditProfileView: View {
    @EnvironmentObject var userData: UserData
    @Binding var isEditing: Bool
    
    var body: some View {
        VStack(spacing: 15) {
            TextField("Name", text: $userData.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Gender", text: $userData.gender)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Age", text: $userData.age)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Height", text: $userData.height)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Weight", text: $userData.weight)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                isEditing = false
            }) {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 10)
        }
        .padding()
    }
}

struct ProfilePreview: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(UserData())
    }
}
