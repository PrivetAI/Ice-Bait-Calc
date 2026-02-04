import SwiftUI

// MARK: - Fish Icon
struct FishIcon: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.primary
    
    var body: some View {
        Canvas { context, canvasSize in
            let scale = size / 24
            
            // Fish body (ellipse)
            let bodyPath = Path(ellipseIn: CGRect(x: 4 * scale, y: 8 * scale, width: 14 * scale, height: 8 * scale))
            context.fill(bodyPath, with: .color(color))
            
            // Tail
            var tailPath = Path()
            tailPath.move(to: CGPoint(x: 2 * scale, y: 12 * scale))
            tailPath.addLine(to: CGPoint(x: 6 * scale, y: 8 * scale))
            tailPath.addLine(to: CGPoint(x: 6 * scale, y: 16 * scale))
            tailPath.closeSubpath()
            context.fill(tailPath, with: .color(color))
            
            // Eye
            let eyePath = Path(ellipseIn: CGRect(x: 14 * scale, y: 10 * scale, width: 3 * scale, height: 3 * scale))
            context.fill(eyePath, with: .color(.white))
            
            // Fin
            var finPath = Path()
            finPath.move(to: CGPoint(x: 10 * scale, y: 8 * scale))
            finPath.addLine(to: CGPoint(x: 12 * scale, y: 4 * scale))
            finPath.addLine(to: CGPoint(x: 14 * scale, y: 8 * scale))
            finPath.closeSubpath()
            context.fill(finPath, with: .color(color.opacity(0.8)))
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Bait Icon
struct BaitIcon: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.secondary
    
    var body: some View {
        Canvas { context, canvasSize in
            let scale = size / 24
            
            // Worm body
            var path = Path()
            path.move(to: CGPoint(x: 4 * scale, y: 18 * scale))
            path.addQuadCurve(
                to: CGPoint(x: 12 * scale, y: 10 * scale),
                control: CGPoint(x: 6 * scale, y: 12 * scale)
            )
            path.addQuadCurve(
                to: CGPoint(x: 20 * scale, y: 6 * scale),
                control: CGPoint(x: 16 * scale, y: 14 * scale)
            )
            
            context.stroke(path, with: .color(color), lineWidth: 3 * scale)
            
            // Head
            let headPath = Path(ellipseIn: CGRect(x: 18 * scale, y: 4 * scale, width: 4 * scale, height: 4 * scale))
            context.fill(headPath, with: .color(color))
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Hole Icon
struct HoleIcon: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.success
    
    var body: some View {
        Canvas { context, canvasSize in
            let scale = size / 24
            
            // Ice surface
            let icePath = Path(roundedRect: CGRect(x: 2 * scale, y: 6 * scale, width: 20 * scale, height: 12 * scale), cornerRadius: 2 * scale)
            context.fill(icePath, with: .color(AppTheme.Colors.surface))
            
            // Hole
            let holePath = Path(ellipseIn: CGRect(x: 6 * scale, y: 8 * scale, width: 12 * scale, height: 8 * scale))
            context.fill(holePath, with: .color(color))
            
            // Inner hole (water)
            let waterPath = Path(ellipseIn: CGRect(x: 8 * scale, y: 10 * scale, width: 8 * scale, height: 4 * scale))
            context.fill(waterPath, with: .color(AppTheme.Colors.primary.opacity(0.6)))
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Clock Icon
struct ClockIcon: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.accent
    
    var body: some View {
        Canvas { context, canvasSize in
            let scale = size / 24
            let center = CGPoint(x: 12 * scale, y: 12 * scale)
            let radius = 9 * scale
            
            // Circle
            let circlePath = Path(ellipseIn: CGRect(x: 3 * scale, y: 3 * scale, width: 18 * scale, height: 18 * scale))
            context.stroke(circlePath, with: .color(color), lineWidth: 2 * scale)
            
            // Hour hand
            var hourPath = Path()
            hourPath.move(to: center)
            hourPath.addLine(to: CGPoint(x: 12 * scale, y: 7 * scale))
            context.stroke(hourPath, with: .color(color), lineWidth: 2 * scale)
            
            // Minute hand
            var minutePath = Path()
            minutePath.move(to: center)
            minutePath.addLine(to: CGPoint(x: 17 * scale, y: 12 * scale))
            context.stroke(minutePath, with: .color(color), lineWidth: 1.5 * scale)
            
            // Center dot
            let dotPath = Path(ellipseIn: CGRect(x: 10.5 * scale, y: 10.5 * scale, width: 3 * scale, height: 3 * scale))
            context.fill(dotPath, with: .color(color))
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Calculator Icon
struct CalculatorIcon: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.primary
    
    var body: some View {
        Canvas { context, canvasSize in
            let scale = size / 24
            
            // Body
            let bodyPath = Path(roundedRect: CGRect(x: 4 * scale, y: 2 * scale, width: 16 * scale, height: 20 * scale), cornerRadius: 2 * scale)
            context.fill(bodyPath, with: .color(color))
            
            // Screen
            let screenPath = Path(roundedRect: CGRect(x: 6 * scale, y: 4 * scale, width: 12 * scale, height: 5 * scale), cornerRadius: 1 * scale)
            context.fill(screenPath, with: .color(AppTheme.Colors.surface))
            
            // Buttons
            let buttonSize = 3 * scale
            let buttonPositions: [(CGFloat, CGFloat)] = [
                (7, 11), (12, 11), (17, 11),
                (7, 15), (12, 15), (17, 15),
                (7, 19), (12, 19), (17, 19)
            ]
            
            for (x, y) in buttonPositions {
                let buttonPath = Path(ellipseIn: CGRect(x: (x - buttonSize/2) * scale, y: (y - buttonSize/2) * scale, width: buttonSize, height: buttonSize))
                context.fill(buttonPath, with: .color(AppTheme.Colors.surface))
            }
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Profile Icon
struct ProfileIcon: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.primary
    
    var body: some View {
        Canvas { context, canvasSize in
            let scale = size / 24
            
            // Folder back
            var folderPath = Path()
            folderPath.move(to: CGPoint(x: 2 * scale, y: 8 * scale))
            folderPath.addLine(to: CGPoint(x: 2 * scale, y: 20 * scale))
            folderPath.addLine(to: CGPoint(x: 22 * scale, y: 20 * scale))
            folderPath.addLine(to: CGPoint(x: 22 * scale, y: 8 * scale))
            folderPath.addLine(to: CGPoint(x: 12 * scale, y: 8 * scale))
            folderPath.addLine(to: CGPoint(x: 10 * scale, y: 5 * scale))
            folderPath.addLine(to: CGPoint(x: 2 * scale, y: 5 * scale))
            folderPath.closeSubpath()
            context.fill(folderPath, with: .color(color))
            
            // Star inside
            let starCenter = CGPoint(x: 12 * scale, y: 14 * scale)
            var starPath = Path()
            for i in 0..<5 {
                let angle = Double(i) * 4 * .pi / 5 - .pi / 2
                let r: CGFloat = i % 2 == 0 ? 4 * scale : 2 * scale
                let point = CGPoint(
                    x: starCenter.x + CGFloat(cos(angle)) * r,
                    y: starCenter.y + CGFloat(sin(angle)) * r
                )
                if i == 0 {
                    starPath.move(to: point)
                } else {
                    starPath.addLine(to: point)
                }
            }
            starPath.closeSubpath()
            context.fill(starPath, with: .color(AppTheme.Colors.accent))
        }
        .frame(width: size, height: size)
    }
}

// MARK: - History Icon
struct HistoryIcon: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.primary
    
    var body: some View {
        Canvas { context, canvasSize in
            let scale = size / 24
            
            // Clock circle with arrow
            let circlePath = Path(ellipseIn: CGRect(x: 4 * scale, y: 4 * scale, width: 16 * scale, height: 16 * scale))
            context.stroke(circlePath, with: .color(color), lineWidth: 2 * scale)
            
            // Arrow
            var arrowPath = Path()
            arrowPath.move(to: CGPoint(x: 12 * scale, y: 2 * scale))
            arrowPath.addLine(to: CGPoint(x: 8 * scale, y: 6 * scale))
            arrowPath.move(to: CGPoint(x: 12 * scale, y: 2 * scale))
            arrowPath.addLine(to: CGPoint(x: 16 * scale, y: 6 * scale))
            context.stroke(arrowPath, with: .color(color), lineWidth: 2 * scale)
            
            // Clock hands
            let center = CGPoint(x: 12 * scale, y: 12 * scale)
            var handsPath = Path()
            handsPath.move(to: center)
            handsPath.addLine(to: CGPoint(x: 12 * scale, y: 8 * scale))
            handsPath.move(to: center)
            handsPath.addLine(to: CGPoint(x: 16 * scale, y: 12 * scale))
            context.stroke(handsPath, with: .color(color), lineWidth: 1.5 * scale)
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Book Icon
struct BookIcon: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.primary
    
    var body: some View {
        Canvas { context, canvasSize in
            let scale = size / 24
            
            // Book cover
            let coverPath = Path(roundedRect: CGRect(x: 4 * scale, y: 3 * scale, width: 16 * scale, height: 18 * scale), cornerRadius: 2 * scale)
            context.fill(coverPath, with: .color(color))
            
            // Pages
            let pagesPath = Path(roundedRect: CGRect(x: 6 * scale, y: 5 * scale, width: 12 * scale, height: 14 * scale), cornerRadius: 1 * scale)
            context.fill(pagesPath, with: .color(.white))
            
            // Lines
            for i in 0..<4 {
                let y = CGFloat(8 + i * 3) * scale
                var linePath = Path()
                linePath.move(to: CGPoint(x: 8 * scale, y: y))
                linePath.addLine(to: CGPoint(x: 16 * scale, y: y))
                context.stroke(linePath, with: .color(color.opacity(0.3)), lineWidth: 1 * scale)
            }
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Plus Icon
struct PlusIcon: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.primary
    
    var body: some View {
        Canvas { context, canvasSize in
            let scale = size / 24
            
            var path = Path()
            path.move(to: CGPoint(x: 12 * scale, y: 4 * scale))
            path.addLine(to: CGPoint(x: 12 * scale, y: 20 * scale))
            path.move(to: CGPoint(x: 4 * scale, y: 12 * scale))
            path.addLine(to: CGPoint(x: 20 * scale, y: 12 * scale))
            
            context.stroke(path, with: .color(color), lineWidth: 2.5 * scale)
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Checkmark Icon
struct CheckmarkIcon: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.success
    
    var body: some View {
        Canvas { context, canvasSize in
            let scale = size / 24
            
            var path = Path()
            path.move(to: CGPoint(x: 5 * scale, y: 12 * scale))
            path.addLine(to: CGPoint(x: 10 * scale, y: 17 * scale))
            path.addLine(to: CGPoint(x: 19 * scale, y: 7 * scale))
            
            context.stroke(path, with: .color(color), lineWidth: 2.5 * scale)
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Trash Icon
struct TrashIcon: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.secondary
    
    var body: some View {
        Canvas { context, canvasSize in
            let scale = size / 24
            
            // Lid
            var lidPath = Path()
            lidPath.move(to: CGPoint(x: 4 * scale, y: 6 * scale))
            lidPath.addLine(to: CGPoint(x: 20 * scale, y: 6 * scale))
            context.stroke(lidPath, with: .color(color), lineWidth: 2 * scale)
            
            // Handle
            var handlePath = Path()
            handlePath.move(to: CGPoint(x: 9 * scale, y: 6 * scale))
            handlePath.addLine(to: CGPoint(x: 9 * scale, y: 4 * scale))
            handlePath.addLine(to: CGPoint(x: 15 * scale, y: 4 * scale))
            handlePath.addLine(to: CGPoint(x: 15 * scale, y: 6 * scale))
            context.stroke(handlePath, with: .color(color), lineWidth: 2 * scale)
            
            // Body
            var bodyPath = Path()
            bodyPath.move(to: CGPoint(x: 6 * scale, y: 8 * scale))
            bodyPath.addLine(to: CGPoint(x: 7 * scale, y: 20 * scale))
            bodyPath.addLine(to: CGPoint(x: 17 * scale, y: 20 * scale))
            bodyPath.addLine(to: CGPoint(x: 18 * scale, y: 8 * scale))
            context.stroke(bodyPath, with: .color(color), lineWidth: 2 * scale)
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Arrow Right Icon
struct ArrowRightIcon: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.textSecondary
    
    var body: some View {
        Canvas { context, canvasSize in
            let scale = size / 24
            
            var path = Path()
            path.move(to: CGPoint(x: 9 * scale, y: 6 * scale))
            path.addLine(to: CGPoint(x: 15 * scale, y: 12 * scale))
            path.addLine(to: CGPoint(x: 9 * scale, y: 18 * scale))
            
            context.stroke(path, with: .color(color), lineWidth: 2 * scale)
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Save Icon
struct SaveIcon: View {
    var size: CGFloat = 24
    var color: Color = AppTheme.Colors.primary
    
    var body: some View {
        Canvas { context, canvasSize in
            let scale = size / 24
            
            // Outer rectangle
            let outerPath = Path(roundedRect: CGRect(x: 4 * scale, y: 4 * scale, width: 16 * scale, height: 16 * scale), cornerRadius: 2 * scale)
            context.fill(outerPath, with: .color(color))
            
            // Top notch
            var notchPath = Path()
            notchPath.addRect(CGRect(x: 8 * scale, y: 4 * scale, width: 8 * scale, height: 6 * scale))
            context.fill(notchPath, with: .color(AppTheme.Colors.surface))
            
            // Inner rect (paper)
            var paperPath = Path()
            paperPath.addRect(CGRect(x: 7 * scale, y: 12 * scale, width: 10 * scale, height: 6 * scale))
            context.fill(paperPath, with: .color(AppTheme.Colors.surface))
        }
        .frame(width: size, height: size)
    }
}
