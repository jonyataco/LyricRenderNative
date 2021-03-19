import SwiftUI

struct LyricTextView: View {
    let index: Int
    let opacity: Double
    let lyric: String
    let fontSize: CGFloat
    let lyricColor: Color
    
    var body: some View {
        Text(lyric)
            .foregroundColor(lyricColor)
            .font(Font.custom("Courier", size: fontSize))
            .transition(.move(edge: .bottom))
            .opacity(Double(index) / opacity)
            .onAppear {
                print(index, opacity)
            }
    }
}

struct LyricTextView_Preview: PreviewProvider {
    static var previews: some View {
        LyricTextView(
            index: 1,
            opacity: 1.0,
            lyric: "Testing",
            fontSize: 50,
            lyricColor: .white
        )
    }
}


