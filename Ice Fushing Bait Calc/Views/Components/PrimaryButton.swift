import SwiftUI

// Rustic-styled action button — pill shape with engraved look
struct RusticButton: View {
    let label: String
    let action: () -> Void
    var wide: Bool = true
    var tone: Tone = .primary

    enum Tone {
        case primary, secondary, danger
        var bg: Color {
            switch self {
            case .primary: return AppTheme.Palette.bark
            case .secondary: return AppTheme.Palette.forestGreen
            case .danger: return AppTheme.Palette.dustyRed
            }
        }
        var fg: Color { AppTheme.Palette.cream }
    }

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(tone.fg)
                .frame(maxWidth: wide ? .infinity : nil)
                .frame(height: 50)
                .padding(.horizontal, wide ? 0 : 28)
                .background(
                    RoundedRectangle(cornerRadius: AppTheme.Radius.button)
                        .fill(tone.bg)
                        .shadow(color: AppTheme.Palette.shadow.opacity(0.35), radius: 4, x: 0, y: 3)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: AppTheme.Radius.button)
                        .stroke(tone.bg.opacity(0.6), lineWidth: 1)
                        .padding(1)
                )
        }
        .buttonStyle(DepressStyle())
    }
}

// Press-down style instead of scale
struct DepressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .offset(y: configuration.isPressed ? 2 : 0)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}
