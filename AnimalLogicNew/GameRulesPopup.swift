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
                .foregroundColor(.black)
                .textFieldStyle(.plain)
                .padding()
            
            ScrollView {
                Text("1. The objective is to remove all the animals.\n\n2. Only animals that are the same shape or color as the previously removed animals are allowed to exit.\n\n3. No animal can jump over another animal to exit, so the last animal in each row must be of the same color or shape.\n\n4. You can shuffle the animals")
                    .font(.subheadline)
                    .foregroundColor(.black)
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


