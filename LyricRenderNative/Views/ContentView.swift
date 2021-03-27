//
//  ContentView.swift
//  LyricRenderNative
//
//  Created by Jonathan Yataco  on 3/16/21.
//

import SwiftUI

struct ContentView: View {
    let backgroundColor: Color
    let textColor: Color
    let fontSize: Double
    let lyricAlignment: HorizontalAlignment
    let lyricAnimation: Animation
    
    @State var lyrics: [String] = []
    @State var currentLyric: String = ""
    @State var opacityValue: Double = 0
    
    var body: some View {
        GeometryReader { geoReader in
            ZStack {
                // Sets the background color
                backgroundColor.ignoresSafeArea()
                
                VStack {
                    // The scroll view for the lyrics
                    ScrollView(.vertical, showsIndicators: false) {
                        Spacer()
                        LazyVStack(alignment: lyricAlignment, spacing: 20) {
                            ForEach(lyrics.indices, id: \.self) { index in
                                LyricTextView(
                                    index: index + 1,
                                    opacity: opacityValue,
                                    lyric: lyrics[index],
                                    fontSize: CGFloat(fontSize),
                                    lyricColor: textColor
                                )
                            }
                        }
                        .padding()
                        .rotationEffect(Angle(degrees: 180))
                    }
                    .rotationEffect(Angle(degrees: 180))
                    .frame(height: geoReader.size.height * 0.6, alignment: .center)
                    
                    // Spacer to push the textfield to the bottom
                    Spacer()
                    
                    // Input text field
                    HStack {
                        TextField(
                            "Enter your next lyrics",
                            text: $currentLyric,
                            onCommit: {
                                withAnimation(lyricAnimation) {
                                    lyrics.append(currentLyric)
                                    opacityValue = Double(lyrics.count)
                                    currentLyric = ""
                                }
                            }
                        )
                        Button("Clear lyrics") {
                            lyrics.removeAll()
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(backgroundColor: .black, textColor: .white, fontSize: 50.0, lyricAlignment: .center, lyricAnimation: .spring())
    }
}

