//
//  Flashcard.swift
//  MyApp
//
//  Created by Eric Dorsey on 11/2/26.
//

import SwiftUI

struct Flashcard: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
}

struct FlashcardView: View {
    
    // MARK: - Flashcards
    let flashcards = [
        Flashcard(
            question: "What is SwiftUI?",
            answer: "A framework for building user interfaces across Apple platforms."
        ),
        Flashcard(
            question: "What does @State do?",
            answer: "It stores changing data that can update a SwiftUI view."
        ),
        Flashcard(
            question: "What is withAnimation?",
            answer: "It animates state changes that happen inside its closure."
        )
    ]
    
    // MARK: - State
    @State private var currentCard = 0
    @State private var isFlipped = false
    
    var body: some View {
        VStack(spacing: 30) {
            
            // Title
            Text("SwiftUI Flashcards")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Card \(currentCard + 1) of \(flashcards.count)")
                .foregroundStyle(.secondary)
            
            // MARK: - Flashcard
            ZStack {
                
                // FRONT
                VStack(spacing: 20) {
                    Text("QUESTION")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.blue)
                    
                    Text(flashcards[currentCard].question)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    
                    Text("Tap to reveal answer")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.blue.opacity(0.1))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.blue, lineWidth: 2)
                )
                .opacity(isFlipped ? 0 : 1)
                
                // BACK
                VStack(spacing: 20) {
                    Text("ANSWER")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.green)
                    
                    Text(flashcards[currentCard].answer)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                    
                    Text("Tap to see question")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.green.opacity(0.1))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.green, lineWidth: 2)
                )
                // This keeps the answer text readable
                .rotation3DEffect(
                    .degrees(180),
                    axis: (x: 0, y: 1, z: 0)
                )
                .opacity(isFlipped ? 1 : 0)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .rotation3DEffect(
                .degrees(isFlipped ? 180 : 0),
                axis: (x: 0, y: 1, z: 0)
            )
            .animation(.easeInOut(duration: 0.6), value: isFlipped)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.6)) {
                    isFlipped.toggle()
                }
            }
            
            // MARK: - Previous / Next Buttons
            HStack(spacing: 20) {
                
                Button {
                    withAnimation {
                        if currentCard > 0 {
                            currentCard -= 1
                        } else {
                            currentCard = flashcards.count - 1
                        }
                        
                        isFlipped = false
                    }
                } label: {
                    Label("Previous", systemImage: "arrow.left")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                
                Button {
                    withAnimation {
                        if currentCard < flashcards.count - 1 {
                            currentCard += 1
                        } else {
                            currentCard = 0
                        }
                        
                        isFlipped = false
                    }
                } label: {
                    Label("Next", systemImage: "arrow.right")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
            
            Spacer()
        }
        .padding()
    }
    
    // MARK: - Card Flip
    var cardRotation: Double {
        isFlipped ? 180 : 0
    }
}

#Preview {
    FlashcardView()
}
