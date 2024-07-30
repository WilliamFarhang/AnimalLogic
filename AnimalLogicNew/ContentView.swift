//
//  ContentView.swift
//  AnimalLogicNew
//
//  Created by william farhang on 2024-07-26.
//
import SwiftUI

struct AnimalCell: View {
    var animal: Animal
    @State private var isInvalidMove = false
    var model: GameModel?
    var row: Int
    var column: Int
    
    var body: some View {
        Image(animal.imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 80, height: 80)
            .background(
                Group {
                    if isInvalidMove {
                        Color.red.cornerRadius(10)
                    } else {
                        NeumorphicBackground()
                    }
                }
            )
            .opacity(animal.imageName.isEmpty ? 0 : 1)
            .animation(.easeInOut, value: animal.imageName.isEmpty)
            .onTapGesture {
                if let model = model, !model.removeAnimal(at: row, column: column) {
                    withAnimation {
                        isInvalidMove = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation {
                            isInvalidMove = false
                        }
                    }
                }
            }
    }
}

struct NeumorphicBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color(UIColor.systemGray6))
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 5, y: 5)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            .padding(2)
    }
}

struct ContentView: View {
    @StateObject private var model = GameModel()
    @State private var showingRules = false
    
    var body: some View {
        ZStack {
            Color(hex: "416E53").ignoresSafeArea(edges: .all)
            
            GeometryReader { geometry in
                VStack {
                    TimerView(secondsElapsed: model.secondsElapsed)
                    ZStack{
                        VStack {
                            AnimalGridView(model: model)
                            
                            if let animal = model.lastRemovedAnimal {
                                LastRemovedAnimalView(animal: animal)
                            }
                        }.opacity(model.gameOver ? 0.30 : 1)
                        if model.gameOver {
                            GameOverView(win: model.win)
                        }
                    }
                    
                    ShuffleButton(model: model)
                    
                    // Game Rules Button
                    Button(action: {
                        showingRules.toggle()
                    }) {
                        Image(systemName: "book.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .overlay(Circle()
                                .stroke(Color.orange, lineWidth: 2))
                    }
                    .padding()
                }
                .background(Color(hex: "416E53").edgesIgnoringSafeArea(.all))
                .frame(width: geometry.size.width, height: geometry.size.height)
                .onChange(of: model.gameOver) { newValue in
                    if newValue {
                        model.timer?.invalidate()
                        model.shuffleActive = false
                    }
                }
            }
            
            // Rules Popup
            if showingRules {
                GameRulesPopup(showingRules: $showingRules)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct TimerView: View {
    var secondsElapsed: Int
    
    var body: some View {
        Text("Time: \(secondsElapsed) seconds")
            .font(.headline)
            .foregroundColor(.white)
            .background(Color(hex: "416E53"))
    }
}

struct AnimalGridView: View {
    @ObservedObject var model: GameModel
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 4), spacing: 0) {
            ForEach(0..<4) { row in
                ForEach(0..<4) { column in
                    AnimalCell(animal: model.grid[row][column], model: model, row: row, column: column)
                        .disabled(model.gameOver)
                }
            }
        }
        .padding()
    }
}

struct LastRemovedAnimalView: View {
    var animal: Animal
    
    var body: some View {
        VStack {
            AnimalCell(animal: animal, model: nil, row: 0, column: 0) // Model, row, and column are not used here
                .padding()
                .frame(width: 80, height: 80)
                .background(NeumorphicBackground())
        }
        .padding(.bottom)
    }
}

struct GameOverView: View {
    var win: Bool
    
    var body: some View {
        ZStack {
            // Lottie animation centered in the middle of the screen
            LottieView(filename: win ? "wining" : "lost", loopMode: .loop)
                .frame(width: 250, height: 250) // Adjust size as needed
                .padding()
        }
    }
}

struct ShuffleButton: View {
    @ObservedObject var model: GameModel
    
    var body: some View {
        Button(action: {
            if model.shuffleActive {
                model.startNewGame()
            } else {
                model.shuffleAnimals()
                model.shuffleActive = true
                model.startTimer()
            }
        }) {
            Text(model.shuffleActive ? "Shuffle" : "Restart Game")
                .font(.headline)
                .padding()
                .background(Color(hex: "f9edcc"))
                .foregroundColor(.black)
                .cornerRadius(10)
                .frame(width: 150) 
        }
        .padding()
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = scanner.string.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = Double((rgbValue & 0xff0000) >> 16) / 255.0
        let g = Double((rgbValue & 0xff00) >> 8) / 255.0
        let b = Double(rgbValue & 0xff) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
