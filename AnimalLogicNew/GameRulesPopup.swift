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
                .textFieldStyle(.plain)
                .padding()
            
            ScrollView {
                Text("1. Tap an animal to remove it from the grid.\n\n2. Animals can only be removed if they match the type or color of the last removed animal.\n\n3. The goal is to clear the grid.\n\n4. Use the Shuffle button to start a new game.")
                    .font(.subheadline)
                    .textFieldStyle(.automatic)
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
        .frame(width: 300, height: 400)
        .background(Color(hex: "f9edcc"))
        .cornerRadius(10)
        .shadow(radius: 20)
        .padding(40)
        .overlay(
            Button(action: {
                showingRules = false
            }) {
                Color.clear 
            }
            .edgesIgnoringSafeArea(.all)
        )
    }
}


