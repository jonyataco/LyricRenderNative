enum LyricAlignment: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    case Leading, Center, Trailing
}
