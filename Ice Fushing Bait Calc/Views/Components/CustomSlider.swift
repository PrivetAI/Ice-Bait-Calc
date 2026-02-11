import SwiftUI

// Rustic range control — thick track with wood-tone fill
struct RangeControl: View {
    let heading: String
    @Binding var value: Double
    let bounds: ClosedRange<Double>
    let step: Double
    let icon: AnyView
    let suffix: String

    var body: some View {
        WoodCard {
            HStack {
                icon
                Text(heading)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundColor(AppTheme.Palette.charcoal)
                Spacer()
                Text("\(Int(value)) \(suffix)")
                    .font(.system(size: 22, weight: .heavy, design: .rounded))
                    .foregroundColor(AppTheme.Palette.bark)
            }

            GeometryReader { geo in
                let pct = CGFloat((value - bounds.lowerBound) / (bounds.upperBound - bounds.lowerBound))
                ZStack(alignment: .leading) {
                    // track bg
                    Capsule()
                        .fill(AppTheme.Palette.wheat)
                        .frame(height: 10)
                    // filled portion
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [AppTheme.Palette.warmOrange, AppTheme.Palette.bark],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: max(10, pct * geo.size.width), height: 10)
                    // thumb
                    Circle()
                        .fill(AppTheme.Palette.cream)
                        .frame(width: 30, height: 30)
                        .shadow(color: AppTheme.Palette.shadow.opacity(0.3), radius: 3, x: 0, y: 2)
                        .overlay(
                            Circle()
                                .fill(AppTheme.Palette.bark)
                                .frame(width: 12, height: 12)
                        )
                        .offset(x: max(0, pct * (geo.size.width - 30)))
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { g in
                                    let raw = bounds.lowerBound + (bounds.upperBound - bounds.lowerBound) * Double(g.location.x / geo.size.width)
                                    let stepped = (raw / step).rounded() * step
                                    value = min(max(stepped, bounds.lowerBound), bounds.upperBound)
                                }
                        )
                }
            }
            .frame(height: 30)
        }
    }
}
