//
//  CustomStartButtonView.swift
//  AnimalLogicNew
//
//  Created by william farhang on 2024-07-28.
//

import SwiftUI

struct CustomStartButtonView: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text("Start")
                    .foregroundColor(Color(hex: "f9edcc"))
                    .font(.headline)
                    .fontWeight(.bold)
                Image(systemName: "pawprint")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35, alignment: .center)
                    .foregroundColor(Color(hex: "f9edcc"))
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 15)
            .background(
                Capsule().strokeBorder(Color(Color(hex: "f9edcc")), lineWidth: 1.25)
            )
        }
    }
}

