import SwiftUI

// Journal section — collapsible list of fishing trip entries
struct JournalSectionView: View {
    @ObservedObject var state: AppState
    @Binding var expanded: Bool
    @State private var showComposer = false
    @State private var selectedEntry: JournalEntry?

    var body: some View {
        VStack(spacing: 0) {
            // Section header
            Button(action: { withAnimation(.easeInOut(duration: 0.25)) { expanded.toggle() } }) {
                HStack {
                    IcoBook(sz: 22, tint: AppTheme.Palette.bark)
                    Text("Bait Journal")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(AppTheme.Palette.charcoal)
                    Spacer()
                    Text("\(state.journal.count)")
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundColor(AppTheme.Palette.cream)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Capsule().fill(AppTheme.Palette.bark))
                    IcoChevronDown(sz: 18, tint: AppTheme.Palette.bark)
                        .rotationEffect(.degrees(expanded ? 0 : -90))
                }
                .padding(.vertical, AppTheme.Spacing.sm)
            }
            .buttonStyle(PlainButtonStyle())

            if expanded {
                VStack(spacing: 10) {
                    RusticButton(label: "Log New Trip", action: { showComposer = true }, tone: .secondary)

                    if state.journal.isEmpty {
                        Text("No entries yet. Tap above to log your first ice fishing trip.")
                            .font(.system(size: 14, design: .rounded))
                            .foregroundColor(AppTheme.Palette.bark.opacity(0.7))
                            .multilineTextAlignment(.center)
                            .padding(.vertical, AppTheme.Spacing.lg)
                    } else {
                        ForEach(state.journal) { entry in
                            JournalRow(entry: entry)
                                .onTapGesture { selectedEntry = entry }
                        }
                    }
                }
                .padding(.top, AppTheme.Spacing.sm)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .sheet(isPresented: $showComposer) {
            EntryComposerView(state: state, existing: nil)
        }
        .sheet(item: $selectedEntry) { entry in
            EntryDetailSheet(state: state, entry: entry)
        }
    }
}

// Single journal row
struct JournalRow: View {
    let entry: JournalEntry

    var body: some View {
        WoodCard {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(entry.species.rawValue) / \(entry.material.rawValue)")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(AppTheme.Palette.charcoal)
                    Text(entry.formattedDate)
                        .font(.system(size: 12, design: .rounded))
                        .foregroundColor(AppTheme.Palette.bark.opacity(0.6))
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    StarDisplayView(rating: entry.starRating, sz: 14)
                    Text(entry.effectiveness.rawValue)
                        .font(.system(size: 11, weight: .semibold, design: .rounded))
                        .foregroundColor(effectivenessColor(entry.effectiveness))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(
                            Capsule().fill(effectivenessColor(entry.effectiveness).opacity(0.15))
                        )
                }
            }
            if !entry.memo.isEmpty {
                Text(entry.memo)
                    .font(.system(size: 13, design: .rounded))
                    .foregroundColor(AppTheme.Palette.charcoal.opacity(0.7))
                    .lineLimit(2)
            }
        }
    }

    private func effectivenessColor(_ e: Effectiveness) -> Color {
        switch e {
        case .poor: return AppTheme.Palette.dustyRed
        case .okay: return AppTheme.Palette.warmOrange
        case .good: return AppTheme.Palette.forestGreen
        case .great: return AppTheme.Palette.forestGreen
        }
    }
}
