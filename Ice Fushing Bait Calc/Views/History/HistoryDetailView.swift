import SwiftUI

// Detail sheet for a journal entry — view and edit
struct EntryDetailSheet: View {
    @ObservedObject var state: AppState
    let entry: JournalEntry
    @Environment(\.presentationMode) var dismiss
    @State private var showEdit = false
    @State private var confirmDelete = false

    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.Palette.parchment.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 14) {
                        // Header
                        WoodCard {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(entry.species.rawValue)
                                        .font(.system(size: 22, weight: .heavy, design: .rounded))
                                        .foregroundColor(AppTheme.Palette.charcoal)
                                    Text(entry.material.rawValue)
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                        .foregroundColor(AppTheme.Palette.bark.opacity(0.7))
                                }
                                Spacer()
                                StarDisplayView(rating: entry.starRating, sz: 20)
                            }
                        }

                        // Stats
                        WoodCard {
                            DetailRow(label: "Date", value: entry.formattedDate)
                            DetailRow(label: "Duration", value: "\(entry.durationHours) hours")
                            DetailRow(label: "Holes", value: "\(entry.holeCount)")
                            if entry.baitUsedGrams > 0 {
                                DetailRow(label: "Bait Used", value: "\(Int(entry.baitUsedGrams)) g")
                            }
                            DetailRow(label: "Effectiveness", value: entry.effectiveness.rawValue)
                            DetailRow(label: "Weather", value: entry.weatherTag.rawValue)
                        }

                        // Estimate comparison
                        let est = BaitCalculator.estimate(species: entry.species, material: entry.material, hours: entry.durationHours, holes: entry.holeCount)
                        WoodCard {
                            Text("Estimated vs Actual")
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                                .foregroundColor(AppTheme.Palette.charcoal)
                            HStack {
                                VStack(spacing: 2) {
                                    Text("\(Int(est.total))")
                                        .font(.system(size: 26, weight: .heavy, design: .rounded))
                                        .foregroundColor(AppTheme.Palette.warmOrange)
                                    Text("estimated g")
                                        .font(.system(size: 11, design: .rounded))
                                        .foregroundColor(AppTheme.Palette.bark.opacity(0.6))
                                }
                                .frame(maxWidth: .infinity)

                                VStack(spacing: 2) {
                                    Text(entry.baitUsedGrams > 0 ? "\(Int(entry.baitUsedGrams))" : "--")
                                        .font(.system(size: 26, weight: .heavy, design: .rounded))
                                        .foregroundColor(AppTheme.Palette.forestGreen)
                                    Text("actual g")
                                        .font(.system(size: 11, design: .rounded))
                                        .foregroundColor(AppTheme.Palette.bark.opacity(0.6))
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }

                        if !entry.memo.isEmpty {
                            WoodCard {
                                Text("Notes")
                                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                                    .foregroundColor(AppTheme.Palette.charcoal)
                                Text(entry.memo)
                                    .font(.system(size: 14, design: .rounded))
                                    .foregroundColor(AppTheme.Palette.charcoal.opacity(0.85))
                                    .lineSpacing(3)
                            }
                        }

                        HStack(spacing: 12) {
                            RusticButton(label: "Edit", action: { showEdit = true }, tone: .secondary)
                            RusticButton(label: "Delete", action: { confirmDelete = true }, tone: .danger)
                        }
                    }
                    .padding(AppTheme.Spacing.md)
                }
            }
            .navigationTitle("Trip Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") { dismiss.wrappedValue.dismiss() }
                        .foregroundColor(AppTheme.Palette.bark)
                }
            }
            .sheet(isPresented: $showEdit) {
                EntryComposerView(state: state, existing: entry)
            }
            .alert(isPresented: $confirmDelete) {
                Alert(
                    title: Text("Delete Entry"),
                    message: Text("This cannot be undone."),
                    primaryButton: .destructive(Text("Delete")) {
                        state.removeJournalEntry(entry)
                        dismiss.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
}

struct DetailRow: View {
    let label: String
    let value: String
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 14, design: .rounded))
                .foregroundColor(AppTheme.Palette.bark.opacity(0.7))
            Spacer()
            Text(value)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundColor(AppTheme.Palette.charcoal)
        }
    }
}
