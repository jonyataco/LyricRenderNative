//
//  LyricRenderNativeApp.swift
//  LyricRenderNative
//
//  Created by Jonathan Yataco  on 3/16/21.
//

import SwiftUI

enum AppSettings {
    static let fontSize = "fontSize"
    static let backgroundColor = "backgroundColor"
    static let lyricColor = "lyricColor"
    static let lyricAlignment = "lyricAlignment"
    static let lyricAnimation = "lyricAnimation"
    static let backgroundOpacity = "backgroundOpacity"
    static let hideClearLyricsButton = "hideClearLyricsButton"
}

@main
struct LyricRenderNativeApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @AppStorage(AppSettings.fontSize) var fontSize: Double = 50
    @AppStorage(AppSettings.backgroundColor) var backgroundColor: String = ""
    @AppStorage(AppSettings.lyricColor) var textColor: String = ""
    @AppStorage(AppSettings.lyricAlignment) var lyricAlignment: String = "Center"
    @AppStorage(AppSettings.lyricAnimation) var lyricAnimation: String = "Spring"
    @AppStorage(AppSettings.backgroundOpacity) var backgroundOpacity: Double = 1.0
    @AppStorage(AppSettings.hideClearLyricsButton) var hideClearLyrics: Bool = true
    
    @State private var bgColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    @State private var txtColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    @State private var duration: Double = 0.0
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                backgroundColor: bgColor,
                textColor: txtColor,
                fontSize: fontSize,
                lyricAlignment: Helper.alignment(lyricAlignment: lyricAlignment),
                lyricAnimation: Helper.animation(lyricAnimation: lyricAnimation)
            )
            // Load from app storage into state
            .onAppear {
                if !backgroundColor.isEmpty {
                    let rgbArray = backgroundColor.components(separatedBy: ",")
                    if let red = Double(rgbArray[0]),
                       let green = Double(rgbArray[1]),
                       let blue = Double(rgbArray[2]),
                       let alpha = Double(rgbArray[3]) {
                        bgColor = Color(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
                    }
                }
                
                if !textColor.isEmpty {
                    let rgbArray = textColor.components(separatedBy: ",")
                    if let red = Double(rgbArray[0]),
                       let green = Double(rgbArray[1]),
                       let blue = Double(rgbArray[2]),
                       let alpha = Double(rgbArray[3]) {
                        txtColor = Color(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
                    }
                }
            }
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        
        Settings {
            VStack {
                Text("Settings Menu")
                    .font(.title)
                    .fontWeight(.bold)
                
                VStack(alignment: .leading) {
                    
                    Slider(value: $fontSize, in: 5...180) {
                        Text("Font size \(fontSize, specifier: "%0.f") pts)")
                    }
                    
                    Slider(value: $backgroundOpacity, in: 0.0...1, step: 0.1) {
                        Text("Background opactiy \(backgroundOpacity)")
                    }
                    
                    ColorPicker("Set the background color", selection: Binding(get: {
                        bgColor
                    }, set: { newValue in
                        backgroundColor = updateColorInStorage(color: newValue)
                        bgColor = newValue
                    }))
                    
                    ColorPicker("Set the text color", selection: Binding(get: {
                        txtColor
                    }, set: { newValue in
                        textColor = updateColorInStorage(color: newValue)
                        txtColor = newValue
                    }))
                    
                    Picker("Lyric Alignment", selection: $lyricAlignment) {
                        ForEach(LyricAlignment.allCases) {
                            Text($0.rawValue).tag($0)
                        }
                    }
                    
                    Picker("Lyric Animation Type", selection: $lyricAnimation) {
                        ForEach(LyricAnimation.allCases) {
                            Text($0.rawValue).tag($0)
                        }
                    }
                    
                    Toggle(isOn: $hideClearLyrics, label: {
                        Text("Hide the clear lyrics button")
                    })
                }
                .padding(.horizontal, 100)
            }
            
            .frame(width: 500, height: 500)
        }
    }
    
    func updateColorInStorage(color: Color) -> String {
        let nsColor = NSColor(color)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        nsColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return "\(red),\(green),\(blue),\(alpha)"
    }
}

final class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        guard let window = NSApplication.shared.windows.first else {
            print("For some reason unable to retrieve the main window")
            return
        }
        
        // Allows the window to be transparent
        window.isOpaque = false
        // NEED THIS OR ELSE FPS WILL BE LOW AS HELL
        window.hasShadow = false
        window.backgroundColor = NSColor.clear
    }
}
