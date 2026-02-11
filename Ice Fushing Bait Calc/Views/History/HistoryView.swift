import SwiftUI

// Seasonal calendar section — collapsible
struct SeasonalCalendarView: View {
    @Binding var expanded: Bool

    var body: some View {
        VStack(spacing: 0) {
            Button(action: { withAnimation(.easeInOut(duration: 0.25)) { expanded.toggle() } }) {
                HStack {
                    IcoCalendar(sz: 22)
                    Text("Seasonal Bait Calendar")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(AppTheme.Palette.charcoal)
                    Spacer()
                    IcoChevronDown(sz: 18, tint: AppTheme.Palette.bark)
                        .rotationEffect(.degrees(expanded ? 0 : -90))
                }
                .padding(.vertical, AppTheme.Spacing.sm)
            }
            .buttonStyle(PlainButtonStyle())

            if expanded {
                VStack(spacing: 12) {
                    ForEach(SeasonalTipStore.tips) { tip in
                        SeasonalTipCard(tip: tip)
                    }
                }
                .padding(.top, AppTheme.Spacing.sm)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }
}

struct SeasonalTipCard: View {
    let tip: SeasonalTip

    var body: some View {
        WoodCard {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(tip.season.rawValue)
                        .font(.system(size: 11, weight: .bold, design: .rounded))
                        .foregroundColor(AppTheme.Palette.cream)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(Capsule().fill(seasonColor(tip.season)))
                    Text(tip.headline)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(AppTheme.Palette.charcoal)
                }
                Spacer()
                Text(tip.monthRange)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundColor(AppTheme.Palette.bark.opacity(0.6))
            }

            Text(tip.body)
                .font(.system(size: 14, design: .rounded))
                .foregroundColor(AppTheme.Palette.charcoal.opacity(0.85))
                .lineSpacing(3)

            // Recommended materials
            HStack(spacing: 6) {
                Text("Bait:")
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundColor(AppTheme.Palette.bark.opacity(0.7))
                ForEach(tip.recommendedMaterials) { mat in
                    Text(mat.rawValue)
                        .font(.system(size: 11, weight: .medium, design: .rounded))
                        .foregroundColor(AppTheme.Palette.charcoal)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(Capsule().fill(AppTheme.Palette.wheat))
                }
            }

            HStack(spacing: 6) {
                Text("Fish:")
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundColor(AppTheme.Palette.bark.opacity(0.7))
                ForEach(tip.topSpecies) { sp in
                    Text(sp.rawValue)
                        .font(.system(size: 11, weight: .medium, design: .rounded))
                        .foregroundColor(AppTheme.Palette.charcoal)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(Capsule().fill(AppTheme.Palette.wheat))
                }
            }
        }
    }

    private func seasonColor(_ s: IceSeason) -> Color {
        switch s {
        case .earlyIce: return AppTheme.Palette.forestGreen
        case .midWinter: return AppTheme.Palette.bark
        case .lateIce: return AppTheme.Palette.warmOrange
        }
    }
}
