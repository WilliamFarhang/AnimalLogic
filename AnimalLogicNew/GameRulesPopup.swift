//
//  GameRulesPopup.swift
//  AnimalLogicNew
//
//  Created by william farhang on 2024-07-26.
//

import SwiftUI

struct GameRulesPopup: View {
    @Binding var showingRules: Bool
    
    var body: some View {
        VStack {
            Text("Game Rules")
                .font(.headline)
                .padding()
            
            ScrollView {
                Text("1. Tap an animal to remove it from the grid.\n2. Animals can only be removed if they match the type or color of the last removed animal.\n3. The goal is to clear the grid.\n4. Use the Shuffle button to start a new game.")
                    .font(.headline)
                    .padding()
            }
            
            Button(action: {
                showingRules = false
            }) {
                Text("Close")
                    .font(.headline)
                    .padding()
                    .background(Color(hex: "416E53"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .frame(width: 300, height: 400) // Ensure the frame size is adequate for scrolling
        .background(Color.orange)
        .cornerRadius(10)
        .shadow(radius: 20)
        .padding(40) // Adjust padding to prevent overlay issues
        .overlay(
            Button(action: {
                showingRules = false
            }) {
                Color.clear // Transparent button for dismissing the popup
            }
            .edgesIgnoringSafeArea(.all)
        )
    }
}


