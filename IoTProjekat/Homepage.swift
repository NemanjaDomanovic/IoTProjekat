//
//  Homepage.swift
//  IoTProjekat
//
//  Created by Nemanja Domanovic on 11/22/24.
//

import SwiftUI
import MapKit

struct HomePageView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // Default to San Francisco
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var showRideRequestAlert = false
    @State private var rideStatusMessage = ""
    
    var body: some View {
        VStack {
            // Map View
            Map(coordinateRegion: $region)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 300)
            
            VStack {
                // Ride status message (just a label)
                Text(rideStatusMessage)
                    .font(.title2)
                    .fontWeight(.medium)
                    .padding(.top)
                
                // Request Ride Button
                Button(action: requestRide) {
                    Text("Request Ride")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                // Your Rides History Button (example)
                Button(action: showRideHistory) {
                    Text("Ride History")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.horizontal)
                .padding(.top, 20)
            }
            .padding(.top, -50) // Overlap the buttons above the map
            
            Spacer()
        }
        .alert(isPresented: $showRideRequestAlert) {
            Alert(title: Text("Ride Requested"),
                  message: Text("Your ride is on the way!"),
                  dismissButton: .default(Text("OK")))
        }
    }
    
    // Function to simulate requesting a ride
    private func requestRide() {
        rideStatusMessage = "Ride is on the way!"
        showRideRequestAlert = true
    }
    
    // Function to simulate showing ride history (can be expanded later)
    private func showRideHistory() {
        // Navigate to another view or show some mock ride history
        rideStatusMessage = "This feature is coming soon."
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
