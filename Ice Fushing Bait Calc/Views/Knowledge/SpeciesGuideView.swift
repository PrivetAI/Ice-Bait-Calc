import SwiftUI

// MARK: - Species Guide Section (dashboard collapsible)

struct SpeciesGuideSectionView: View {
    @Binding var expanded: Bool
    @State private var selectedSpecies: FishSpecies?

    var body: some View {
        VStack(spacing: 0) {
            Button(action: { withAnimation(.easeInOut(duration: 0.25)) { expanded.toggle() } }) {
                HStack {
                    IcoFish(sz: 22, tint: AppTheme.Palette.forestGreen)
                    Text("Species Guide")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(AppTheme.Palette.charcoal)
                    Spacer()
                    Text("\(FishSpecies.allCases.count)")
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundColor(AppTheme.Palette.cream)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Capsule().fill(AppTheme.Palette.forestGreen))
                    IcoChevronDown(sz: 18, tint: AppTheme.Palette.bark)
                        .rotationEffect(.degrees(expanded ? 0 : -90))
                }
                .padding(.vertical, AppTheme.Spacing.sm)
            }
            .buttonStyle(PlainButtonStyle())

            if expanded {
                VStack(spacing: 10) {
                    ForEach(FishSpecies.allCases) { species in
                        Button(action: { selectedSpecies = species }) {
                            WoodCard {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(species.rawValue)
                                            .font(.system(size: 16, weight: .bold, design: .rounded))
                                            .foregroundColor(AppTheme.Palette.charcoal)
                                        Text(species.note)
                                            .font(.system(size: 13, design: .rounded))
                                            .foregroundColor(AppTheme.Palette.bark.opacity(0.7))
                                            .lineLimit(2)
                                    }
                                    Spacer()
                                    VStack(alignment: .trailing, spacing: 2) {
                                        Text(species.averageSizeIceFishing)
                                            .font(.system(size: 11, weight: .medium, design: .rounded))
                                            .foregroundColor(AppTheme.Palette.bark.opacity(0.5))
                                        IcoChevronDown(sz: 16, tint: AppTheme.Palette.bark)
                                            .rotationEffect(.degrees(-90))
                                    }
                                }
                            }
                        }
                        .buttonStyle(DepressStyle())
                    }
                }
                .padding(.top, AppTheme.Spacing.sm)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .sheet(item: $selectedSpecies) { species in
            SpeciesDetailSheet(species: species)
        }
    }
}

// MARK: - Species Detail Sheet

struct SpeciesDetailSheet: View {
    let species: FishSpecies
    @Environment(\.presentationMode) var dismiss

    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.Palette.parchment.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Header
                        WoodCard {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(species.rawValue)
                                        .font(.system(size: 24, weight: .heavy, design: .rounded))
                                        .foregroundColor(AppTheme.Palette.charcoal)
                                    Text(species.averageSizeIceFishing)
                                        .font(.system(size: 14, weight: .medium, design: .rounded))
                                        .foregroundColor(AppTheme.Palette.bark.opacity(0.7))
                                }
                                Spacer()
                                IcoFish(sz: 40, tint: AppTheme.Palette.forestGreen)
                            }
                        }

                        // Description
                        sectionCard(title: "About") {
                            Text(species.speciesDescription)
                                .font(.system(size: 15, design: .rounded))
                                .foregroundColor(AppTheme.Palette.charcoal)
                                .lineSpacing(4)
                        }

                        // Preferred Baits
                        sectionCard(title: "Preferred Baits") {
                            FlowLayoutV2(items: species.preferredBaits, spacing: 6) { bait in
                                Text(bait.rawValue)
                                    .font(.system(size: 13, weight: .medium, design: .rounded))
                                    .foregroundColor(AppTheme.Palette.charcoal)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Capsule().fill(AppTheme.Palette.wheat))
                            }
                        }

                        // Best Time
                        sectionCard(title: "Best Time of Day") {
                            Text(species.bestTimeOfDay)
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(AppTheme.Palette.bark)
                        }

                        // Habitat
                        sectionCard(title: "Habitat Preferences") {
                            Text(species.habitatPreferences)
                                .font(.system(size: 15, design: .rounded))
                                .foregroundColor(AppTheme.Palette.charcoal)
                                .lineSpacing(4)
                        }

                        // Tips
                        sectionCard(title: "Tips for Catching") {
                            Text(species.catchingTips)
                                .font(.system(size: 15, design: .rounded))
                                .foregroundColor(AppTheme.Palette.charcoal)
                                .lineSpacing(4)
                        }

                        // Consumption rates table
                        sectionCard(title: "Bait Consumption (g/hr/hole)") {
                            VStack(spacing: 4) {
                                ForEach(BaitMaterial.allCases) { mat in
                                    HStack {
                                        Text(mat.rawValue)
                                            .font(.system(size: 13, design: .rounded))
                                            .foregroundColor(AppTheme.Palette.bark.opacity(0.7))
                                        Spacer()
                                        let rate = species.consumptionRates[mat] ?? 0
                                        Text("\(Int(rate)) g")
                                            .font(.system(size: 13, weight: .semibold, design: .rounded))
                                            .foregroundColor(AppTheme.Palette.charcoal)
                                    }
                                }
                            }
                        }
                    }
                    .padding(AppTheme.Spacing.md)
                }
            }
            .navigationTitle(species.rawValue)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") { dismiss.wrappedValue.dismiss() }
                        .foregroundColor(AppTheme.Palette.bark)
                }
            }
        }
    }

    private func sectionCard<C: View>(title: String, @ViewBuilder content: @escaping () -> C) -> some View {
        WoodCard {
            Text(title)
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .foregroundColor(AppTheme.Palette.warmOrange)
            content()
        }
    }
}
