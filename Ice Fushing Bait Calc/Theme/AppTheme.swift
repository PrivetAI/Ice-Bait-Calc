import SwiftUI

// MARK: - Rustic Theme (warm earthy tones, wood texture feel)
struct AppTheme {
    struct Palette {
        static let bark = Color(r8: 101, g8: 67, b8: 33)
        static let darkWood = Color(r8: 62, g8: 39, b8: 18)
        static let warmOrange = Color(r8: 204, g8: 119, b8: 34)
        static let forestGreen = Color(r8: 53, g8: 94, b8: 59)
        static let cream = Color(r8: 255, g8: 243, b8: 224)
        static let parchment = Color(r8: 245, g8: 230, b8: 205)
        static let charcoal = Color(r8: 54, g8: 42, b8: 33)
        static let dustyRed = Color(r8: 163, g8: 65, b8: 44)
        static let wheat = Color(r8: 222, g8: 198, b8: 160)
        static let shadow = Color(r8: 40, g8: 28, b8: 18)
    }

    struct Radius {
        static let card: CGFloat = 14
        static let button: CGFloat = 10
        static let chip: CGFloat = 18
        static let section: CGFloat = 20
    }

    struct Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 14
        static let lg: CGFloat = 20
        static let xl: CGFloat = 28
    }
}

// MARK: - Color helpers (no hex strings — different from old approach)
extension Color {
    init(r8: Int, g8: Int, b8: Int, a: Double = 1.0) {
        self.init(.sRGB,
                  red: Double(r8) / 255.0,
                  green: Double(g8) / 255.0,
                  blue: Double(b8) / 255.0,
                  opacity: a)
    }
}

// MARK: - Wood-grain background modifier
struct WoodGrain: ViewModifier {
    var depth: CGFloat = 0.06
    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    AppTheme.Palette.parchment
                    // Subtle diagonal stripes to simulate wood grain
                    GeometryReader { geo in
                        ForEach(0..<Int(geo.size.width / 18), id: \.self) { i in
                            Rectangle()
                                .fill(AppTheme.Palette.bark.opacity(Double.random(in: 0.02...depth)))
                                .frame(width: 2, height: geo.size.height * 1.5)
                                .rotationEffect(.degrees(12))
                                .offset(x: CGFloat(i) * 18 - 10, y: -20)
                        }
                    }
                    .clipped()
                }
            )
    }
}

extension View {
    func woodGrain(depth: CGFloat = 0.06) -> some View {
        modifier(WoodGrain(depth: depth))
    }
}
