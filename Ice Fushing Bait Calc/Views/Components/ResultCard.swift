import SwiftUI

// WoodCard — a rounded card with wood-grain background
struct WoodCard<Content: View>: View {
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            content()
        }
        .padding(AppTheme.Spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: AppTheme.Radius.card)
                    .fill(AppTheme.Palette.cream)
                // faint grain overlay
                RoundedRectangle(cornerRadius: AppTheme.Radius.card)
                    .fill(
                        LinearGradient(
                            colors: [
                                AppTheme.Palette.wheat.opacity(0.4),
                                AppTheme.Palette.cream.opacity(0.1),
                                AppTheme.Palette.wheat.opacity(0.3)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
        )
        .overlay(
            RoundedRectangle(cornerRadius: AppTheme.Radius.card)
                .stroke(AppTheme.Palette.bark.opacity(0.18), lineWidth: 1)
        )
        .shadow(color: AppTheme.Palette.shadow.opacity(0.12), radius: 6, x: 0, y: 3)
    }
}

// Star rating view (interactive)
struct StarRatingView: View {
    @Binding var rating: Int
    var maxStars: Int = 5
    var sz: CGFloat = 28

    var body: some View {
        HStack(spacing: 4) {
            ForEach(1...maxStars, id: \.self) { star in
                Button(action: { rating = star }) {
                    IcoStar(sz: sz, filled: star <= rating)
                }
                .buttonStyle(DepressStyle())
            }
        }
    }
}

// Read-only star display
struct StarDisplayView: View {
    let rating: Int
    var sz: CGFloat = 16

    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...5, id: \.self) { star in
                IcoStar(sz: sz, filled: star <= rating)
            }
        }
    }
}
