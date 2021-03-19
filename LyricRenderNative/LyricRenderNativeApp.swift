//
//  LyricRenderNativeApp.swift
//  LyricRenderNative
//
//  Created by Jonathan Yataco  on 3/16/21.
//

import SwiftUI

@main
struct LyricRenderNativeApp: App {
    @AppStorage("fontSize") var fontSize: Double = 50
    @AppStorage("backgroundColor") var backgroundColor: String = ""
    @AppStorage("lyricColor") var textColor: String = ""
    
    @State private var bgColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    @State private var txtColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)

    var body: some Scene {
        WindowGroup {
            ContentView(backgroundColor: bgColor, textColor: txtColor)
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
        
        Settings {
            VStack {
                Text("Settings Menu")
                    .font(.title)
                    .fontWeight(.bold)
            
                VStack(alignment: .leading) {
                
                    Slider(value: $fontSize, in: 5...96) {
                        Text("Font size \(fontSize, specifier: "%0.f") pts)")
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
