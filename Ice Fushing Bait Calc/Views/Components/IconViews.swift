import SwiftUI

// MARK: - All-new shape-based icons (no SF Symbols, no emoji)

struct IcoFish: View {
    var sz: CGFloat = 26
    var tint: Color = AppTheme.Palette.forestGreen
    var body: some View {
        Canvas { ctx, size in
            let w = size.width; let h = size.height
            var body = Path()
            body.addEllipse(in: CGRect(x: w * 0.2, y: h * 0.25, width: w * 0.55, height: h * 0.5))
            ctx.fill(body, with: .color(tint))
            // tail
            var tail = Path()
            tail.move(to: CGPoint(x: w * 0.15, y: h * 0.5))
            tail.addLine(to: CGPoint(x: 0, y: h * 0.2))
            tail.addLine(to: CGPoint(x: 0, y: h * 0.8))
            tail.closeSubpath()
            ctx.fill(tail, with: .color(tint))
            // eye
            var eye = Path()
            eye.addEllipse(in: CGRect(x: w * 0.58, y: h * 0.38, width: w * 0.1, height: w * 0.1))
            ctx.fill(eye, with: .color(.white))
            // fin
            var fin = Path()
            fin.move(to: CGPoint(x: w * 0.4, y: h * 0.25))
            fin.addLine(to: CGPoint(x: w * 0.5, y: h * 0.08))
            fin.addLine(to: CGPoint(x: w * 0.6, y: h * 0.28))
            fin.closeSubpath()
            ctx.fill(fin, with: .color(tint.opacity(0.7)))
        }
        .frame(width: sz, height: sz)
    }
}

struct IcoWorm: View {
    var sz: CGFloat = 26
    var tint: Color = AppTheme.Palette.dustyRed
    var body: some View {
        Canvas { ctx, size in
            let w = size.width; let h = size.height
            var p = Path()
            p.move(to: CGPoint(x: w * 0.1, y: h * 0.8))
            p.addCurve(to: CGPoint(x: w * 0.9, y: h * 0.2),
                       control1: CGPoint(x: w * 0.25, y: h * 0.2),
                       control2: CGPoint(x: w * 0.7, y: h * 0.85))
            ctx.stroke(p, with: .color(tint), lineWidth: sz * 0.12)
            var head = Path()
            head.addEllipse(in: CGRect(x: w * 0.82, y: h * 0.12, width: w * 0.14, height: w * 0.14))
            ctx.fill(head, with: .color(tint))
        }
        .frame(width: sz, height: sz)
    }
}

struct IcoHole: View {
    var sz: CGFloat = 26
    var tint: Color = AppTheme.Palette.bark
    var body: some View {
        ZStack {
            // ice slab
            RoundedRectangle(cornerRadius: 3)
                .fill(AppTheme.Palette.wheat)
                .frame(width: sz * 0.9, height: sz * 0.45)
            // dark hole
            Ellipse()
                .fill(tint)
                .frame(width: sz * 0.45, height: sz * 0.3)
            Ellipse()
                .fill(AppTheme.Palette.darkWood)
                .frame(width: sz * 0.3, height: sz * 0.16)
        }
        .frame(width: sz, height: sz)
    }
}

struct IcoClock: View {
    var sz: CGFloat = 26
    var tint: Color = AppTheme.Palette.warmOrange
    var body: some View {
        ZStack {
            Circle()
                .stroke(tint, lineWidth: sz * 0.09)
                .frame(width: sz * 0.72, height: sz * 0.72)
            // minute
            Capsule()
                .fill(tint)
                .frame(width: sz * 0.06, height: sz * 0.28)
                .offset(y: -sz * 0.1)
            // hour
            Capsule()
                .fill(tint)
                .frame(width: sz * 0.06, height: sz * 0.2)
                .rotationEffect(.degrees(90))
                .offset(x: sz * 0.06)
            Circle()
                .fill(tint)
                .frame(width: sz * 0.09, height: sz * 0.09)
        }
        .frame(width: sz, height: sz)
    }
}

struct IcoStar: View {
    var sz: CGFloat = 26
    var filled: Bool = true
    var tint: Color = AppTheme.Palette.warmOrange
    var body: some View {
        StarPath()
            .fill(filled ? tint : tint.opacity(0.2))
            .frame(width: sz, height: sz)
    }
}

struct StarPath: Shape {
    func path(in rect: CGRect) -> Path {
        let cx = rect.midX; let cy = rect.midY
        let or2 = min(rect.width, rect.height) / 2
        let ir = or2 * 0.38
        var p = Path()
        for i in 0..<10 {
            let a = Double(i) * .pi / 5 - .pi / 2
            let r = i % 2 == 0 ? or2 : ir
            let pt = CGPoint(x: cx + CGFloat(cos(a)) * r, y: cy + CGFloat(sin(a)) * r)
            if i == 0 { p.move(to: pt) } else { p.addLine(to: pt) }
        }
        p.closeSubpath()
        return p
    }
}

struct IcoPlus: View {
    var sz: CGFloat = 26
    var tint: Color = AppTheme.Palette.cream
    var body: some View {
        ZStack {
            Capsule().fill(tint).frame(width: sz * 0.55, height: sz * 0.15)
            Capsule().fill(tint).frame(width: sz * 0.15, height: sz * 0.55)
        }
        .frame(width: sz, height: sz)
    }
}

struct IcoTrash: View {
    var sz: CGFloat = 26
    var tint: Color = AppTheme.Palette.dustyRed
    var body: some View {
        Canvas { ctx, size in
            let w = size.width; let h = size.height
            // lid
            var lid = Path()
            lid.addRoundedRect(in: CGRect(x: w * 0.2, y: h * 0.1, width: w * 0.6, height: h * 0.1), cornerSize: CGSize(width: 2, height: 2))
            ctx.fill(lid, with: .color(tint))
            // handle
            var handle = Path()
            handle.addRoundedRect(in: CGRect(x: w * 0.37, y: h * 0.02, width: w * 0.26, height: h * 0.12), cornerSize: CGSize(width: 3, height: 3))
            ctx.stroke(handle, with: .color(tint), lineWidth: sz * 0.06)
            // body
            var b = Path()
            b.move(to: CGPoint(x: w * 0.25, y: h * 0.24))
            b.addLine(to: CGPoint(x: w * 0.3, y: h * 0.9))
            b.addLine(to: CGPoint(x: w * 0.7, y: h * 0.9))
            b.addLine(to: CGPoint(x: w * 0.75, y: h * 0.24))
            b.closeSubpath()
            ctx.fill(b, with: .color(tint))
        }
        .frame(width: sz, height: sz)
    }
}

struct IcoChevronDown: View {
    var sz: CGFloat = 20
    var tint: Color = AppTheme.Palette.bark
    var body: some View {
        Path { p in
            p.move(to: CGPoint(x: sz * 0.2, y: sz * 0.3))
            p.addLine(to: CGPoint(x: sz * 0.5, y: sz * 0.7))
            p.addLine(to: CGPoint(x: sz * 0.8, y: sz * 0.3))
        }
        .stroke(tint, style: StrokeStyle(lineWidth: sz * 0.1, lineCap: .round, lineJoin: .round))
        .frame(width: sz, height: sz)
    }
}

struct IcoSnowflake: View {
    var sz: CGFloat = 26
    var tint: Color = AppTheme.Palette.bark
    var body: some View {
        Canvas { ctx, size in
            let cx = size.width / 2; let cy = size.height / 2
            let armLen = min(size.width, size.height) * 0.38
            for i in 0..<6 {
                let angle = Double(i) * .pi / 3
                var arm = Path()
                arm.move(to: CGPoint(x: cx, y: cy))
                arm.addLine(to: CGPoint(x: cx + CGFloat(cos(angle)) * armLen,
                                        y: cy + CGFloat(sin(angle)) * armLen))
                ctx.stroke(arm, with: .color(tint), lineWidth: sz * 0.06)
            }
        }
        .frame(width: sz, height: sz)
    }
}

struct IcoBook: View {
    var sz: CGFloat = 26
    var tint: Color = AppTheme.Palette.bark
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: sz * 0.1)
                .fill(tint)
                .frame(width: sz * 0.65, height: sz * 0.78)
            RoundedRectangle(cornerRadius: sz * 0.06)
                .fill(AppTheme.Palette.cream)
                .frame(width: sz * 0.48, height: sz * 0.58)
            VStack(spacing: sz * 0.07) {
                ForEach(0..<3, id: \.self) { _ in
                    Capsule()
                        .fill(tint.opacity(0.3))
                        .frame(width: sz * 0.32, height: sz * 0.04)
                }
            }
        }
        .frame(width: sz, height: sz)
    }
}

struct IcoCalendar: View {
    var sz: CGFloat = 26
    var tint: Color = AppTheme.Palette.forestGreen
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: sz * 0.1)
                .fill(tint)
                .frame(width: sz * 0.72, height: sz * 0.72)
                .offset(y: sz * 0.06)
            RoundedRectangle(cornerRadius: sz * 0.06)
                .fill(AppTheme.Palette.cream)
                .frame(width: sz * 0.58, height: sz * 0.44)
                .offset(y: sz * 0.14)
            // top rings
            HStack(spacing: sz * 0.22) {
                Capsule().fill(tint).frame(width: sz * 0.08, height: sz * 0.18)
                Capsule().fill(tint).frame(width: sz * 0.08, height: sz * 0.18)
            }
            .offset(y: -sz * 0.18)
        }
        .frame(width: sz, height: sz)
    }
}
