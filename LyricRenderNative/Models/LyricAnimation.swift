enum LyricAnimation: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    case Spring, EaseIn, EaseInOut, EaseOut, InteractiveSpring, Linear
}
