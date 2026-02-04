import SwiftUI

struct PrimaryButton: View {
    let title: String
    let icon: AnyView?
    let action: () -> Void
    var isFullWidth: Bool = true
    var style: ButtonStyle = .primary
    
    enum ButtonStyle {
        case primary
        case secondary
        case accent
        
        var backgroundColor: Color {
            switch self {
            case .primary:
                return AppTheme.Colors.primary
            case .secondary:
                return AppTheme.Colors.surface
            case .accent:
                return AppTheme.Colors.secondary
            }
        }
        
        var foregroundColor: Color {
            switch self {
            case .primary, .accent:
                return .white
            case .secondary:
                return AppTheme.Colors.primary
            }
        }
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                if let icon = icon {
                    icon
                }
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            .foregroundColor(style.foregroundColor)
            .frame(maxWidth: isFullWidth ? .infinity : nil)
            .frame(height: AppTheme.Dimensions.buttonHeight)
            .padding(.horizontal, isFullWidth ? 0 : 24)
            .background(
                RoundedRectangle(cornerRadius: AppTheme.Dimensions.cornerRadius)
                    .fill(style.backgroundColor)
                    .shadow(
                        color: style.backgroundColor.opacity(0.4),
                        radius: AppTheme.Shadows.buttonShadowRadius,
                        x: 0,
                        y: 4
                    )
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

struct ScaleButtonStyle: SwiftUI.ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}
