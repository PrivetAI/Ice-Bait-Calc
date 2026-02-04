import SwiftUI

struct CustomSlider: View {
    let title: String
    @Binding var value: Double
    let range: ClosedRange<Double>
    let step: Double
    let icon: AnyView
    let unit: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                icon
                Text(title)
                    .font(.headline)
                    .foregroundColor(AppTheme.Colors.textPrimary)
                Spacer()
                Text("\(Int(value)) \(unit)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(AppTheme.Colors.primary)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Track background
                    RoundedRectangle(cornerRadius: 8)
                        .fill(AppTheme.Colors.surface)
                        .frame(height: 8)
                    
                    // Filled track
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            LinearGradient(
                                colors: [AppTheme.Colors.primary, AppTheme.Colors.success],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: max(0, CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound)) * geometry.size.width), height: 8)
                    
                    // Thumb
                    Circle()
                        .fill(AppTheme.Colors.cardBackground)
                        .frame(width: 28, height: 28)
                        .shadow(color: AppTheme.Colors.primary.opacity(0.3), radius: 4, x: 0, y: 2)
                        .overlay(
                            Circle()
                                .fill(AppTheme.Colors.primary)
                                .frame(width: 12, height: 12)
                        )
                        .offset(x: max(0, CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound)) * (geometry.size.width - 28)))
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { gesture in
                                    let newValue = range.lowerBound + (range.upperBound - range.lowerBound) * Double(gesture.location.x / geometry.size.width)
                                    let steppedValue = round(newValue / step) * step
                                    value = min(max(steppedValue, range.lowerBound), range.upperBound)
                                }
                        )
                }
            }
            .frame(height: 28)
        }
        .padding(AppTheme.Dimensions.padding)
        .cardStyle()
    }
}
