import SwiftUI

struct PrimaryButton: View {
    let title: String
    var iconView: AnyView? = nil
    let action: () -> Void
    var isFullWidth: Bool = true
    var style: ButtonStyleType = .primary
    
    enum ButtonStyleType {
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
                if let iconView = iconView {
                    iconView
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

// Convenience initializer without icon
extension PrimaryButton {
    init(title: String, action: @escaping () -> Void, isFullWidth: Bool = true, style: ButtonStyleType = .primary) {
        self.title = title
        self.iconView = nil
        self.action = action
        self.isFullWidth = isFullWidth
        self.style = style
    }
}

struct ScaleButtonStyle: SwiftUI.ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}
