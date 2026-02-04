import SwiftUI

// MARK: - Tab Bar Icons (using Image for tab items)
struct TabIconCalculator: View {
    var body: some View {
        Image(uiImage: createCalculatorImage())
            .renderingMode(.template)
    }
    
    private func createCalculatorImage() -> UIImage {
        let size = CGSize(width: 24, height: 24)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            let ctx = context.cgContext
            let color = UIColor.black
            
            // Body
            ctx.setFillColor(color.cgColor)
            ctx.fill(CGRect(x: 4, y: 2, width: 16, height: 20))
            
            // Screen
            ctx.setFillColor(UIColor.white.cgColor)
            ctx.fill(CGRect(x: 6, y: 4, width: 12, height: 5))
            
            // Buttons
            ctx.setFillColor(UIColor.white.cgColor)
            let positions: [(CGFloat, CGFloat)] = [
                (7, 11), (12, 11), (17, 11),
                (7, 14), (12, 14), (17, 14),
                (7, 17), (12, 17), (17, 17)
            ]
            for (x, y) in positions {
                ctx.fillEllipse(in: CGRect(x: x - 1.5, y: y - 1.5, width: 3, height: 3))
            }
        }
    }
}

struct TabIconProfile: View {
    var body: some View {
        Image(uiImage: createProfileImage())
            .renderingMode(.template)
    }
    
    private func createProfileImage() -> UIImage {
        let size = CGSize(width: 24, height: 24)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            let ctx = context.cgContext
            let color = UIColor.black
            
            ctx.setFillColor(color.cgColor)
            
            // Folder shape
            ctx.move(to: CGPoint(x: 2, y: 8))
            ctx.addLine(to: CGPoint(x: 2, y: 20))
            ctx.addLine(to: CGPoint(x: 22, y: 20))
            ctx.addLine(to: CGPoint(x: 22, y: 8))
            ctx.addLine(to: CGPoint(x: 12, y: 8))
            ctx.addLine(to: CGPoint(x: 10, y: 5))
            ctx.addLine(to: CGPoint(x: 2, y: 5))
            ctx.closePath()
            ctx.fillPath()
        }
    }
}

struct TabIconHistory: View {
    var body: some View {
        Image(uiImage: createHistoryImage())
            .renderingMode(.template)
    }
    
    private func createHistoryImage() -> UIImage {
        let size = CGSize(width: 24, height: 24)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            let ctx = context.cgContext
            let color = UIColor.black
            
            ctx.setStrokeColor(color.cgColor)
            ctx.setLineWidth(2)
            
            // Circle
            ctx.strokeEllipse(in: CGRect(x: 4, y: 4, width: 16, height: 16))
            
            // Clock hands
            ctx.move(to: CGPoint(x: 12, y: 12))
            ctx.addLine(to: CGPoint(x: 12, y: 8))
            ctx.move(to: CGPoint(x: 12, y: 12))
            ctx.addLine(to: CGPoint(x: 16, y: 12))
            ctx.strokePath()
        }
    }
}

struct TabIconBook: View {
    var body: some View {
        Image(uiImage: createBookImage())
            .renderingMode(.template)
    }
    
    private func createBookImage() -> UIImage {
        let size = CGSize(width: 24, height: 24)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            let ctx = context.cgContext
            let color = UIColor.black
            
            ctx.setFillColor(color.cgColor)
            ctx.fill(CGRect(x: 4, y: 3, width: 16, height: 18))
            
            ctx.setFillColor(UIColor.white.cgColor)
            ctx.fill(CGRect(x: 6, y: 5, width: 12, height: 14))
            
            // Lines
            ctx.setStrokeColor(color.withAlphaComponent(0.3).cgColor)
            ctx.setLineWidth(1)
            for i in 0..<4 {
                let y = CGFloat(8 + i * 3)
                ctx.move(to: CGPoint(x: 8, y: y))
                ctx.addLine(to: CGPoint(x: 16, y: y))
            }
            ctx.strokePath()
        }
    }
}

// MARK: - Inline Icons for Buttons and UI
struct FishIcon: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.primary
    
    var body: some View {
        ZStack {
            // Body
            Ellipse()
                .fill(color)
                .frame(width: size * 0.6, height: size * 0.35)
            
            // Tail
            Triangle()
                .fill(color)
                .frame(width: size * 0.2, height: size * 0.3)
                .rotationEffect(.degrees(90))
                .offset(x: -size * 0.35)
            
            // Eye
            Circle()
                .fill(Color.white)
                .frame(width: size * 0.1, height: size * 0.1)
                .offset(x: size * 0.15, y: -size * 0.02)
        }
        .frame(width: size, height: size)
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct BaitIcon: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.secondary
    
    var body: some View {
        ZStack {
            // Worm body using curved shape
            WormShape()
                .stroke(color, lineWidth: size * 0.12)
                .frame(width: size * 0.7, height: size * 0.6)
            
            // Head
            Circle()
                .fill(color)
                .frame(width: size * 0.15, height: size * 0.15)
                .offset(x: size * 0.25, y: -size * 0.2)
        }
        .frame(width: size, height: size)
    }
}

struct WormShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addQuadCurve(
            to: CGPoint(x: rect.midX, y: rect.midY),
            control: CGPoint(x: rect.minX + rect.width * 0.2, y: rect.midY)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: rect.minY),
            control: CGPoint(x: rect.midX + rect.width * 0.3, y: rect.midY + rect.height * 0.2)
        )
        return path
    }
}

struct HoleIcon: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.success
    
    var body: some View {
        ZStack {
            // Ice surface
            RoundedRectangle(cornerRadius: 2)
                .fill(AppTheme.Colors.surface)
                .frame(width: size * 0.85, height: size * 0.5)
            
            // Hole
            Ellipse()
                .fill(color)
                .frame(width: size * 0.5, height: size * 0.35)
            
            // Water inside
            Ellipse()
                .fill(AppTheme.Colors.primary.opacity(0.6))
                .frame(width: size * 0.35, height: size * 0.18)
        }
        .frame(width: size, height: size)
    }
}

struct ClockIcon: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.accent
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(color, lineWidth: size * 0.08)
                .frame(width: size * 0.75, height: size * 0.75)
            
            // Hour hand
            RoundedRectangle(cornerRadius: 1)
                .fill(color)
                .frame(width: size * 0.08, height: size * 0.22)
                .offset(y: -size * 0.08)
            
            // Minute hand
            RoundedRectangle(cornerRadius: 1)
                .fill(color)
                .frame(width: size * 0.06, height: size * 0.18)
                .rotationEffect(.degrees(90))
                .offset(x: size * 0.06)
            
            // Center
            Circle()
                .fill(color)
                .frame(width: size * 0.1, height: size * 0.1)
        }
        .frame(width: size, height: size)
    }
}

struct CalculatorIconView: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.primary
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.08)
                .fill(color)
                .frame(width: size * 0.7, height: size * 0.85)
            
            // Screen
            RoundedRectangle(cornerRadius: 2)
                .fill(AppTheme.Colors.surface)
                .frame(width: size * 0.5, height: size * 0.2)
                .offset(y: -size * 0.22)
            
            // Buttons grid
            VStack(spacing: size * 0.06) {
                ForEach(0..<2, id: \.self) { _ in
                    HStack(spacing: size * 0.08) {
                        ForEach(0..<3, id: \.self) { _ in
                            Circle()
                                .fill(AppTheme.Colors.surface)
                                .frame(width: size * 0.1, height: size * 0.1)
                        }
                    }
                }
            }
            .offset(y: size * 0.12)
        }
        .frame(width: size, height: size)
    }
}

struct PlusIcon: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.primary
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 2)
                .fill(color)
                .frame(width: size * 0.6, height: size * 0.15)
            
            RoundedRectangle(cornerRadius: 2)
                .fill(color)
                .frame(width: size * 0.15, height: size * 0.6)
        }
        .frame(width: size, height: size)
    }
}

struct CheckmarkIcon: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.success
    
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: size * 0.2, y: size * 0.5))
            path.addLine(to: CGPoint(x: size * 0.4, y: size * 0.7))
            path.addLine(to: CGPoint(x: size * 0.8, y: size * 0.3))
        }
        .stroke(color, style: StrokeStyle(lineWidth: size * 0.1, lineCap: .round, lineJoin: .round))
        .frame(width: size, height: size)
    }
}

struct TrashIcon: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.secondary
    
    var body: some View {
        ZStack {
            // Lid
            RoundedRectangle(cornerRadius: 1)
                .fill(color)
                .frame(width: size * 0.65, height: size * 0.08)
                .offset(y: -size * 0.3)
            
            // Handle
            RoundedRectangle(cornerRadius: 2)
                .stroke(color, lineWidth: size * 0.08)
                .frame(width: size * 0.25, height: size * 0.1)
                .offset(y: -size * 0.38)
            
            // Body
            TrapezoidShape()
                .fill(color)
                .frame(width: size * 0.55, height: size * 0.5)
                .offset(y: size * 0.08)
        }
        .frame(width: size, height: size)
    }
}

struct TrapezoidShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX + rect.width * 0.1, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - rect.width * 0.1, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - rect.width * 0.2, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + rect.width * 0.2, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct ArrowRightIcon: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.textSecondary
    
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: size * 0.35, y: size * 0.25))
            path.addLine(to: CGPoint(x: size * 0.65, y: size * 0.5))
            path.addLine(to: CGPoint(x: size * 0.35, y: size * 0.75))
        }
        .stroke(color, style: StrokeStyle(lineWidth: size * 0.1, lineCap: .round, lineJoin: .round))
        .frame(width: size, height: size)
    }
}

struct SaveIcon: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.primary
    
    var body: some View {
        ZStack {
            // Outer
            RoundedRectangle(cornerRadius: size * 0.08)
                .fill(color)
                .frame(width: size * 0.7, height: size * 0.7)
            
            // Top notch
            Rectangle()
                .fill(AppTheme.Colors.surface)
                .frame(width: size * 0.3, height: size * 0.2)
                .offset(y: -size * 0.22)
            
            // Paper
            Rectangle()
                .fill(AppTheme.Colors.surface)
                .frame(width: size * 0.4, height: size * 0.22)
                .offset(y: size * 0.12)
        }
        .frame(width: size, height: size)
    }
}

struct ProfileIcon: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.primary
    
    var body: some View {
        ZStack {
            // Folder
            FolderShape()
                .fill(color)
                .frame(width: size * 0.85, height: size * 0.65)
            
            // Star
            StarShape()
                .fill(AppTheme.Colors.accent)
                .frame(width: size * 0.3, height: size * 0.3)
                .offset(y: size * 0.05)
        }
        .frame(width: size, height: size)
    }
}

struct FolderShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY + rect.height * 0.2))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + rect.height * 0.2))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY + rect.height * 0.2))
        path.addLine(to: CGPoint(x: rect.midX - rect.width * 0.1, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}

struct StarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outerRadius = min(rect.width, rect.height) / 2
        let innerRadius = outerRadius * 0.4
        
        for i in 0..<10 {
            let angle = Double(i) * .pi / 5 - .pi / 2
            let radius = i % 2 == 0 ? outerRadius : innerRadius
            let point = CGPoint(
                x: center.x + CGFloat(cos(angle)) * radius,
                y: center.y + CGFloat(sin(angle)) * radius
            )
            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        path.closeSubpath()
        return path
    }
}

struct HistoryIcon: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.primary
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(color, lineWidth: size * 0.08)
                .frame(width: size * 0.7, height: size * 0.7)
            
            // Hands
            Path { path in
                let center = CGPoint(x: size / 2, y: size / 2)
                path.move(to: center)
                path.addLine(to: CGPoint(x: size / 2, y: size * 0.3))
                path.move(to: center)
                path.addLine(to: CGPoint(x: size * 0.65, y: size / 2))
            }
            .stroke(color, lineWidth: size * 0.06)
            
            // Arrow at top
            Path { path in
                path.move(to: CGPoint(x: size * 0.35, y: size * 0.12))
                path.addLine(to: CGPoint(x: size * 0.5, y: size * 0.05))
                path.addLine(to: CGPoint(x: size * 0.65, y: size * 0.12))
            }
            .stroke(color, style: StrokeStyle(lineWidth: size * 0.08, lineCap: .round, lineJoin: .round))
        }
        .frame(width: size, height: size)
    }
}

struct BookIcon: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.primary
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.08)
                .fill(color)
                .frame(width: size * 0.7, height: size * 0.8)
            
            RoundedRectangle(cornerRadius: size * 0.04)
                .fill(Color.white)
                .frame(width: size * 0.5, height: size * 0.6)
            
            // Lines
            VStack(spacing: size * 0.08) {
                ForEach(0..<3, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 1)
                        .fill(color.opacity(0.3))
                        .frame(width: size * 0.35, height: size * 0.04)
                }
            }
        }
        .frame(width: size, height: size)
    }
}

// Keep these for compatibility but they won't be used in tabs
struct CalculatorIcon: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.primary
    
    var body: some View {
        CalculatorIconView(size: size, color: color)
    }
}
