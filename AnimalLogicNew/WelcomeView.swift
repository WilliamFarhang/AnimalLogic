//
//  Welcome.swift
//  AnimalLogicNew
//
//  Created by william farhang on 2024-07-28.
//

import SwiftUI

struct WelcomeView: View {
    @State private var isActive: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    // Title
                    Text("Brain Safari")
                        .foregroundColor(Color(hex: "f9edcc"))
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
                    
                    // Headline
                    Text("Walkthrough of the Animal Logic Game")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .fontWeight(.heavy)
                        .padding(.horizontal, 16)
                        .frame(maxWidth: 480)
                        .padding()
                    
                    // Image
                    Image("gav2")
                        .resizable()
                        .scaledToFit()
                        .shadow(color: Color(red: 0, green: 0, blue: 0), radius: 8, x: 6, y: 8)
                        .padding(.vertical, 16)
                    
                    // Start Button
                        .padding()
                    CustomStartButtonView {
                        isActive = true
                    }
                }
                
                // Navigation Link
                NavigationLink(
                    destination: ContentView(),
                    isActive: $isActive
                ) {
                    EmptyView()
                }
                .hidden()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color(Color(hex: "416E53"))]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(20)
        }
    }
}
