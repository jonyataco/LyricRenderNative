//
//  ContentView.swift
//  LyricRenderNative
//
//  Created by Jonathan Yataco  on 3/16/21.
//

import SwiftUI
import Introspect

struct ContentView: View {
    let backgroundColor: Color
    let textColor: Color
    let fontSize: Double
    let lyricAlignment: HorizontalAlignment
    let lyricAnimation: Animation
    
    @AppStorage(AppSettings.backgroundOpacity) var backgroundOpacity: Double = 1.0
    
    @State var lyrics: [String] = [""]
    @State var currentLyric: String = ""
    @State var opacityValue: Double = 0
    
    var body: some View {
        GeometryReader { geoReader in
            ZStack {
                // Sets the background color and opacity
                backgroundColor.ignoresSafeArea().opacity(backgroundOpacity)
                
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
                            text: $lyrics[lyrics.count - 1],
                            onCommit: {
                                withAnimation(lyricAnimation) {
                                    lyrics.append("")
                                    opacityValue = Double(lyrics.count)
                                }
                            }
                        )
                        // Makes the text field invisible and makes it first responder. First responder means that it is focused automatically
                        .opacity(0.0)
                        .modifier(IntrospectSetFirstResponderTextField())
                        
                        Button("Clear lyrics") {
                            // If the lyric count is equal to 1 then just make it an empty string
                            if lyrics.count == 1 {
                                lyrics[0] = ""
                                return
                            }
                            
                            // Remove all of the lyrics except the first one. Make the first one an empty string
                            lyrics[0] = ""
                            lyrics.removeLast(lyrics.count - 1)
                            opacityValue = Double(lyrics.count)
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

