//
//  model.swift
//  AnimalLogicNew
//
//  Created by william farhang on 2024-07-26.
//

import SwiftUI

enum AnimalType: String {
    case lion, giraff, camel, hippo
}

enum AnimalColor: String {
    case red, yellow, blue, green
}

struct Animal: Identifiable {
    var id = UUID()
    var imageName: String

    var type: AnimalType {
        switch imageName {
        case let name where name.contains("lion"):
            return .lion
        case let name where name.contains("giraff"):
            return .giraff
        case let name where name.contains("camel"):
            return .camel
        case let name where name.contains("hippo"):
            return .hippo
        default:
            return .lion // Default value
        }
    }
    
    var color: AnimalColor {
        switch imageName {
        case let name where name.contains("1"):
            return .red
        case let name where name.contains("2"):
            return .yellow
        case let name where name.contains("3"):
            return .blue
        case let name where name.contains("4"):
            return .green
        default:
            return .red // Default value
        }
    }
}

class GameModel: ObservableObject {
    @Published var grid = Array(repeating: Array(repeating: Animal(imageName: ""), count: 4), count: 4)
    @Published var lastRemovedAnimal: Animal? = nil
    @Published var gameOver = false
    @Published var win = false
    @Published var secondsElapsed = 0
    @Published var shuffleActive = false
    
    var timer: Timer? = nil
    private let animals = ["lion1", "lion2", "lion3", "lion4",
                           "giraff1", "giraff2", "giraff3", "giraff4",
                           "camel1", "camel2", "camel3", "camel4",
                           "hippo1", "hippo2", "hippo3", "hippo4"]
    
    init() {
        startNewGame()
    }
    
    func generateAnimals() {
        var tempAnimals = [Animal]()
        
        for imageName in animals {
            tempAnimals.append(Animal(imageName: imageName))
        }
        
        tempAnimals.shuffle()
        
        for row in 0..<4 {
            for column in 0..<4 {
                grid[row][column] = tempAnimals.removeFirst()
            }
        }
    }
    
    func startNewGame() {
        generateAnimals()
        lastRemovedAnimal = nil
        gameOver = false
        win = false
        secondsElapsed = 0
        startTimer()
        shuffleActive = true
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.secondsElapsed += 1
        }
    }
    
    func shuffleAnimals() {
        startNewGame()
    }
    
    func removeAnimal(at row: Int, column: Int) -> Bool {
        guard row == 3 else { return false }
        
        let animal = grid[row][column]
        
        if lastRemovedAnimal == nil || (lastRemovedAnimal?.type == animal.type || lastRemovedAnimal?.color == animal.color) {
            lastRemovedAnimal = animal
        } else {
            return false
        }
        
        withAnimation {
            for r in (1...3).reversed() {
                grid[r][column] = grid[r - 1][column]
            }
            grid[0][column] = Animal(imageName: "")
        }
        
        if !canRemoveAnyAnimal() {
            gameOver = true
            win = grid.flatMap { $0 }.allSatisfy { $0.imageName == "" }
        }
        
        return true
    }
    
    func canRemoveAnyAnimal() -> Bool {
        for column in 0..<4 {
            if grid[3][column].imageName != "" && (lastRemovedAnimal == nil || lastRemovedAnimal?.type == grid[3][column].type || lastRemovedAnimal?.color == grid[3][column].color) {
                return true
            }
        }
        return false
    }
}

