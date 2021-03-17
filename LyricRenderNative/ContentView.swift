//
//  ContentView.swift
//  LyricRenderNative
//
//  Created by Jonathan Yataco  on 3/16/21.
//

import SwiftUI

struct ContentView: View {
    @State var lyrics: [String] = []
    @State var currentLyric: String = ""
    @State var opacityValue: Double = 0

    var body: some View {
        ZStack {
            // Sets the background color
            Color.black.ignoresSafeArea()
            
            VStack {
                if !lyrics.isEmpty {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(lyrics.indices, id: \.self) { index in
                            LyricText(index: index + 1, opacity: opacityValue, lyric: lyrics[index])
                        }
                    }
                }
                TextField(
                    "Enter your next lyrics",
                    text: $currentLyric,
                    onCommit: {
                        withAnimation(.linear(duration: 0.5)) {
                            lyrics.append(currentLyric)
                            opacityValue = Double(lyrics.count)
                        }
                        
                        currentLyric = ""
                    }
                )
            }
        }
    }
}

struct LyricText: View {
    let index: Int
    let opacity: Double
    let lyric: String
    
    var body: some View {
        Text(lyric)
            .font(Font.custom("Courier", size: 50))
            .transition(.move(edge: .bottom))
            .opacity(Double(index) / opacity)
            .onAppear {
                print(index, opacity)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

