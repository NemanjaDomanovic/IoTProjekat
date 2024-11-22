//
//  ContentView.swift
//  IoTProjekat
//
//  Created by Nemanja Domanovic on 11/22/24.
//

import SwiftUI

struct User: Codable {
    let username: String
    let password: String
}
struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoginMode: Bool = true
    @State private var message: String = ""
    @State private var isLoginSuccessful: Bool = false // Track login success

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Username and Password fields
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding(.horizontal)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // Action button for login or register
                Button(action: handleAction) {
                    Text(isLoginMode ? "Login" : "Register")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                // Message display
                Text(message)
                    .foregroundColor(.red)
                    .padding()
                
                // Navigation link to HomePageView if login is successful
                NavigationLink(
                    destination: HomePageView(),
                    isActive: $isLoginSuccessful) {
                        EmptyView()
                    }
            }
            .padding()
        }
    }
    
    // Handle the Login or Register action
    private func handleAction() {
        if username.isEmpty || password.isEmpty {
            message = "Please fill in all fields."
            return
        }
        
        if isLoginMode {
            // Handle Login
            if loginUser(username: username, password: password) {
                message = "Login successful!"
                isLoginSuccessful = true  // Set login success flag to true
            } else {
                message = "Invalid username or password."
            }
        } else {
            // Handle Registration
            if registerUser(username: username, password: password) {
                message = "Registration successful!"
            } else {
                message = "Username already exists."
            }
        }
    }
    
    // MARK: - UserDefaults Functions
    
    // Save users to UserDefaults
    private func saveUsers(_ users: [User]) {
        if let encodedData = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(encodedData, forKey: "users")
        }
    }
    
    // Fetch users from UserDefaults
    private func fetchUsers() -> [User] {
        if let data = UserDefaults.standard.data(forKey: "users"),
           let decodedUsers = try? JSONDecoder().decode([User].self, from: data) {
            return decodedUsers
        }
        return []
    }
    
    // Register a new user
    private func registerUser(username: String, password: String) -> Bool {
        var users = fetchUsers()
        
        // Check if username already exists
        if users.contains(where: { $0.username == username }) {
            return false
        }
        
        // Add new user and save
        let newUser = User(username: username, password: password)
        users.append(newUser)
        saveUsers(users)
        return true
    }
    
    // Login user
    private func loginUser(username: String, password: String) -> Bool {
        let users = fetchUsers()
        return users.contains { $0.username == username && $0.password == password }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
