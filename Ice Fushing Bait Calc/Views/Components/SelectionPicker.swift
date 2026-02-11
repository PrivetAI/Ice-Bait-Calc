import SwiftUI

// Chip-style picker — wrapped chips inside a WoodCard
struct ChipPicker<T: Hashable & Identifiable & RawRepresentable>: View where T.RawValue == String {
    let heading: String
    let icon: AnyView
    let items: [T]
    @Binding var picked: T

    var body: some View {
        WoodCard {
            HStack(spacing: 6) {
                icon
                Text(heading)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundColor(AppTheme.Palette.charcoal)
            }

            ChipFlowLayout {
                ForEach(items) { item in
                    Chip(
                        text: item.rawValue,
                        active: picked.id == item.id,
                        onTap: { picked = item }
                    )
                }
            }
        }
    }
}

struct Chip: View {
    let text: String
    let active: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(text)
                .font(.system(size: 13, weight: active ? .bold : .medium, design: .rounded))
                .foregroundColor(active ? AppTheme.Palette.cream : AppTheme.Palette.charcoal)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(active ? AppTheme.Palette.forestGreen : AppTheme.Palette.wheat.opacity(0.7))
                )
                .overlay(
                    Capsule()
                        .stroke(active ? AppTheme.Palette.forestGreen : AppTheme.Palette.bark.opacity(0.2), lineWidth: 1)
                )
        }
        .buttonStyle(DepressStyle())
    }
}

// MARK: - Flow Layout using per-child alignment guides

struct ChipFlowLayout: View {
    let spacing: CGFloat
    let content: AnyView

    init<C: View>(spacing: CGFloat = 8, @ViewBuilder _ content: () -> C) {
        self.spacing = spacing
        self.content = AnyView(content())
    }

    var body: some View {
        // Use LazyVGrid with adaptive columns — reliable wrapping on iOS 15
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 80), spacing: spacing)],
            alignment: .leading,
            spacing: spacing
        ) {
            content
        }
    }
}

// MARK: - FlowLayout alias (for any other references)
struct FlowLayout: View {
    let spacing: CGFloat
    let content: () -> AnyView

    init<Content: View>(spacing: CGFloat = 6, @ViewBuilder content: @escaping () -> Content) {
        self.spacing = spacing
        self.content = { AnyView(content()) }
    }

    var body: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 80), spacing: spacing)],
            alignment: .leading,
            spacing: spacing
        ) {
            content()
        }
    }
}

// MARK: - Legacy wrapper
struct WrappingHStack<Item: Identifiable, Content: View>: View {
    let items: [Item]
    let content: (Item) -> Content

    var body: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 80), spacing: 6)],
            alignment: .leading,
            spacing: 6
        ) {
            ForEach(items) { item in
                content(item)
            }
        }
    }
}

// Keep FlowLayoutV2 for compatibility
struct FlowLayoutV2<Item: Identifiable, ItemView: View>: View {
    let items: [Item]
    let spacing: CGFloat
    let content: (Item) -> ItemView

    var body: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 80), spacing: spacing)],
            alignment: .leading,
            spacing: spacing
        ) {
            ForEach(items) { item in
                content(item)
            }
        }
    }
}
