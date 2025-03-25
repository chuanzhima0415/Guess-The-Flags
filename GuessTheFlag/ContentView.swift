//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by 马传智 on 2025/3/17.
//

import SwiftUI

struct ContentView: View {
	@State var questionCount = 0
	@State var equalToEight = false // 一旦玩了 8 次，此 alert 触发
	@State var showingScores = false
	@State var scoreTitle = ""
	@State var countries = ["UK", "US", "Spain", "Ukraine", "Poland", "Nigeria"].shuffled()
	@State var correctAnswer = Int.random(in: 0 ..< 3)
	@State var selectedWrongCountry = ""
	@State var playerScore = 0
	var body: some View {
		ZStack {
			RadialGradient(stops: [
				Gradient.Stop(color: Color(red: 72 / 255, green: 70 / 255, blue: 109 / 255), location: 0.3),
				Gradient.Stop(color: Color(red: 186 / 255, green: 39 / 255, blue: 54 / 255), location: 0.3)
			], center: .top, startRadius: 200, endRadius: 700)
				.ignoresSafeArea()

			VStack {
				Spacer()
				Text("Guess the Flag")
					.font(.title.weight(.bold))
					.foregroundStyle(.white)

				VStack(spacing: 15) {
					VStack {
						Text("tap the flag of")
							.foregroundStyle(.secondary)
							.font(.title2.weight(.heavy))
						Text(countries[correctAnswer])
							.font(.largeTitle.weight(.bold))
					}

					ForEach(0 ..< 3) { number in
						Button {
							tapFlag(number)
						} label: {
							Image(countries[number])
								.clipShape(.capsule)
								.shadow(radius: 15)
						}
					}
					.alert("\(scoreTitle)!", isPresented: $showingScores) {
						Button("Continue", action: askQuestion)
					} message: {
						scoreTitle == "Correct" ? Text("Yep, you're right, +5 points") : Text("That’s the flag of \(selectedWrongCountry)")
					}
				}
				.frame(maxWidth: .infinity)
				.padding(.vertical, 20)
				.background(.ultraThinMaterial)
				.clipShape(.rect(cornerRadius: 20))
				.alert("Game ends", isPresented: $equalToEight) {
					Button("Reset", action: reset)
				} message: {
					Text("You've played 8 times, time to take a rest")
				}

				Spacer()

				Text("Score: \(playerScore)")
					.font(.title.weight(.bold))
					.foregroundStyle(.white)

				Spacer()
			}
			.padding()
		}
	}

	func tapFlag(_ index: Int) {
		if index == correctAnswer {
			scoreTitle = "Correct"
			playerScore += 5
		} else {
			scoreTitle = "Wrong"
			selectedWrongCountry = countries[index]
		}
		questionCount += 1
		equalToEight = questionCount == 8
		showingScores = true
	}

	func askQuestion() {
		countries.shuffle()
		correctAnswer = Int.random(in: 0 ..< 3)
	}

	func reset() {
		scoreTitle = ""
		questionCount = 0
		playerScore = 0
		selectedWrongCountry = ""
		countries.shuffle()
		correctAnswer = Int.random(in: 0 ..< 3)
	}
}

#Preview {
	ContentView()
}
