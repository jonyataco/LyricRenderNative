import SwiftUI

class Helper {
    /// Helper method that takes in a string, and returns the corresponding HoriztonalAlignment. By default returns Center
    static func alignment(lyricAlignment: String) -> HorizontalAlignment {
        let alignment = LyricAlignment(rawValue: lyricAlignment) ?? LyricAlignment.Center
    
        switch alignment {
        case .Center:
            return HorizontalAlignment.center
        case .Leading:
            return HorizontalAlignment.leading
        case .Trailing:
            return HorizontalAlignment.trailing
        }
    }
    
    static func animation(lyricAnimation: String) -> Animation {
        let animation = LyricAnimation(rawValue: lyricAnimation) ?? LyricAnimation.Spring
        
        switch animation {
        case .Spring:
            return Animation.spring()
        case .EaseIn:
            return Animation.easeIn
        case .EaseInOut:
            return Animation.easeInOut
        case .EaseOut:
            return Animation.easeOut
        case .InteractiveSpring:
            return Animation.interactiveSpring()
        case .Linear:
            return Animation.linear
        }
    }
}
