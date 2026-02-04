import SwiftUI

struct ResultCard: View {
    let title: String
    let value: String
    let subtitle: String?
    let icon: AnyView?
    var accentColor: Color = AppTheme.Colors.primary
    
    var body: some View {
        VStack(spacing: 8) {
            if let icon = icon {
                icon
            }
            
            Text(value)
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(accentColor)
            
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(AppTheme.Colors.textPrimary)
            
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(AppTheme.Colors.textSecondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(AppTheme.Dimensions.padding)
        .cardStyle()
    }
}

struct LargeResultCard: View {
    let value: String
    let unit: String
    let subtitle: String
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(alignment: .lastTextBaseline, spacing: 4) {
                Text(value)
                    .font(.system(size: 64, weight: .bold, design: .rounded))
                    .foregroundColor(AppTheme.Colors.primary)
                
                Text(unit)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(AppTheme.Colors.textSecondary)
            }
            
            Text(subtitle)
                .font(.headline)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(AppTheme.Dimensions.largePadding)
        .background(
            RoundedRectangle(cornerRadius: AppTheme.Dimensions.cardCornerRadius)
                .fill(
                    LinearGradient(
                        colors: [AppTheme.Colors.surface, AppTheme.Colors.cardBackground],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: AppTheme.Dimensions.cardCornerRadius)
                .stroke(AppTheme.Colors.primary.opacity(0.2), lineWidth: 2)
        )
        .shadow(
            color: AppTheme.Colors.primary.opacity(0.1),
            radius: AppTheme.Shadows.cardShadowRadius,
            x: 0,
            y: AppTheme.Shadows.cardShadowY
        )
    }
}
