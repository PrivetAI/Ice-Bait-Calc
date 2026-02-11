import SwiftUI

// Entry composer — sheet to create or edit a journal entry
struct EntryComposerView: View {
    @ObservedObject var state: AppState
    let existing: JournalEntry?
    @Environment(\.presentationMode) var dismiss

    @State private var species: FishSpecies = .perch
    @State private var material: BaitMaterial = .bloodworm
    @State private var hours: Double = 4
    @State private var holes: Double = 3
    @State private var gramsUsed: String = ""
    @State private var effectiveness: Effectiveness = .okay
    @State private var weather: WeatherTag = .overcast
    @State private var memo: String = ""
    @State private var stars: Int = 3

    var isEdit: Bool { existing != nil }

    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.Palette.parchment.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 14) {
                        // Species
                        ChipPicker(
                            heading: "Target Species",
                            icon: AnyView(IcoFish(sz: 22)),
                            items: FishSpecies.allCases,
                            picked: $species
                        )

                        // Material
                        ChipPicker(
                            heading: "Bait Used",
                            icon: AnyView(IcoWorm(sz: 22)),
                            items: BaitMaterial.allCases,
                            picked: $material
                        )

                        // Duration
                        RangeControl(
                            heading: "Hours Fished",
                            value: $hours,
                            bounds: 1...12,
                            step: 1,
                            icon: AnyView(IcoClock(sz: 22)),
                            suffix: "hr"
                        )

                        // Holes
                        RangeControl(
                            heading: "Holes Drilled",
                            value: $holes,
                            bounds: 1...10,
                            step: 1,
                            icon: AnyView(IcoHole(sz: 22)),
                            suffix: "holes"
                        )

                        // Estimated amount with breakdown
                        estimateCard

                        // Actual grams
                        WoodCard {
                            Text("Actual Bait Used (grams)")
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                                .foregroundColor(AppTheme.Palette.charcoal)
                            TextField("e.g. 120", text: $gramsUsed)
                                .keyboardType(.numberPad)
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(AppTheme.Palette.bark)
                                .padding(10)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(AppTheme.Palette.wheat.opacity(0.5))
                                )
                        }

                        // Effectiveness
                        ChipPicker(
                            heading: "Effectiveness",
                            icon: AnyView(IcoStar(sz: 20, filled: true, tint: AppTheme.Palette.warmOrange)),
                            items: Effectiveness.allCases,
                            picked: $effectiveness
                        )

                        // Weather
                        ChipPicker(
                            heading: "Weather",
                            icon: AnyView(IcoSnowflake(sz: 20, tint: AppTheme.Palette.bark)),
                            items: WeatherTag.allCases,
                            picked: $weather
                        )

                        // Star rating
                        WoodCard {
                            Text("Overall Rating")
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                                .foregroundColor(AppTheme.Palette.charcoal)
                            StarRatingView(rating: $stars, sz: 32)
                        }

                        // Memo
                        WoodCard {
                            Text("Notes")
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                                .foregroundColor(AppTheme.Palette.charcoal)
                            TextEditor(text: $memo)
                                .frame(minHeight: 80)
                                .font(.system(size: 14, design: .rounded))
                                .foregroundColor(AppTheme.Palette.charcoal)
                                .padding(6)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(AppTheme.Palette.wheat.opacity(0.4))
                                )
                                .cornerRadius(8)
                        }

                        RusticButton(label: isEdit ? "Update Entry" : "Save Entry", action: save)
                            .padding(.top, 6)
                    }
                    .padding(AppTheme.Spacing.md)
                }
            }
            .navigationTitle(isEdit ? "Edit Trip" : "Log Trip")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss.wrappedValue.dismiss() }
                        .foregroundColor(AppTheme.Palette.bark)
                }
            }
            .onAppear(perform: loadExisting)
        }
    }

    private var estimateCard: some View {
        let bd = BaitCalculator.detailedBreakdown(species: species, material: material, hours: Int(hours), holes: Int(holes))
        return WoodCard {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Estimated Need")
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundColor(AppTheme.Palette.bark.opacity(0.7))
                    Text("\(Int(bd.total)) g")
                        .font(.system(size: 28, weight: .heavy, design: .rounded))
                        .foregroundColor(AppTheme.Palette.warmOrange)
                }
                Spacer()
            }

            // Breakdown rows
            VStack(alignment: .leading, spacing: 4) {
                breakdownRow(label: "Base rate", value: "\(Int(bd.baseAmount)) g/hr/hole")
                breakdownRow(label: "Start feed (\(Int(holes)) holes)", value: "\(Int(bd.startFeed)) g")
                breakdownRow(label: "Hourly feed", value: "\(Int(bd.hourlyFeed)) g/hr")
                breakdownRow(label: "Species factor", value: String(format: "%.1fx (%@)", bd.speciesFactor, bd.speciesFactorLabel))
            }
            .padding(.top, 4)
        }
    }

    private func breakdownRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 12, design: .rounded))
                .foregroundColor(AppTheme.Palette.charcoal.opacity(0.6))
            Spacer()
            Text(value)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundColor(AppTheme.Palette.charcoal.opacity(0.8))
        }
    }

    private func loadExisting() {
        guard let e = existing else { return }
        species = e.species
        material = e.material
        hours = Double(e.durationHours)
        holes = Double(e.holeCount)
        gramsUsed = e.baitUsedGrams > 0 ? "\(Int(e.baitUsedGrams))" : ""
        effectiveness = e.effectiveness
        weather = e.weatherTag
        memo = e.memo
        stars = e.starRating
    }

    private func save() {
        let grams = Double(gramsUsed) ?? 0
        if isEdit, let old = existing {
            var updated = old
            updated.species = species
            updated.material = material
            updated.durationHours = Int(hours)
            updated.holeCount = Int(holes)
            updated.baitUsedGrams = grams
            updated.effectiveness = effectiveness
            updated.weatherTag = weather
            updated.memo = memo
            updated.starRating = stars
            updated.editedAt = Date()
            state.updateJournalEntry(updated)
        } else {
            let entry = JournalEntry(
                species: species,
                material: material,
                durationHours: Int(hours),
                holeCount: Int(holes),
                baitUsedGrams: grams,
                effectiveness: effectiveness,
                weatherTag: weather,
                memo: memo,
                starRating: stars
            )
            state.addJournalEntry(entry)
        }
        dismiss.wrappedValue.dismiss()
    }
}
