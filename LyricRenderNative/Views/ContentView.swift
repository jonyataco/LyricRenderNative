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

    @State var lyrics: [String] = []
    @State var currentLyric: String = ""
    @State var opacityValue: Double = 0
    
    

    var body: some View {
        ZStack {
            // Sets the background color
            backgroundColor.ignoresSafeArea()
            
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    ScrollViewReader { scrollView in
                        LazyVStack(alignment: .center, spacing: 20) {
                            ForEach(lyrics.indices, id: \.self) { index in
                                LyricTextView(
                                    index: index + 1,
                                    opacity: opacityValue,
                                    lyric: lyrics[index],
                                    fontSize: 50,
                                    lyricColor: textColor
                                )
                            }
                        }.onAppear {
                            if !lyrics.isEmpty {
                                scrollView.scrollTo(lyrics[lyrics.endIndex - 1])
                            }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(backgroundColor: .black, textColor: .white)
    }
}

