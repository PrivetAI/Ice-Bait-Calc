import SwiftUI

// MARK: - Bait Encyclopedia Section (dashboard collapsible)

struct BaitEncyclopediaSectionView: View {
    @Binding var expanded: Bool
    @State private var selectedBait: BaitMaterial?

    var body: some View {
        VStack(spacing: 0) {
            Button(action: { withAnimation(.easeInOut(duration: 0.25)) { expanded.toggle() } }) {
                HStack {
                    IcoWorm(sz: 22, tint: AppTheme.Palette.dustyRed)
                    Text("Bait Encyclopedia")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(AppTheme.Palette.charcoal)
                    Spacer()
                    Text("\(BaitMaterial.allCases.count)")
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundColor(AppTheme.Palette.cream)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Capsule().fill(AppTheme.Palette.dustyRed))
                    IcoChevronDown(sz: 18, tint: AppTheme.Palette.bark)
                        .rotationEffect(.degrees(expanded ? 0 : -90))
                }
                .padding(.vertical, AppTheme.Spacing.sm)
            }
            .buttonStyle(PlainButtonStyle())

            if expanded {
                VStack(spacing: 10) {
                    ForEach(BaitMaterial.allCases) { bait in
                        Button(action: { selectedBait = bait }) {
                            WoodCard {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        HStack(spacing: 6) {
                                            Text(bait.rawValue)
                                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                                .foregroundColor(AppTheme.Palette.charcoal)
                                            // Effectiveness stars
                                            HStack(spacing: 1) {
                                                ForEach(1...5, id: \.self) { i in
                                                    IcoStar(sz: 10, filled: i <= bait.effectivenessRating, tint: AppTheme.Palette.warmOrange)
                                                }
                                            }
                                        }
                                        Text(bait.briefNote)
                                            .font(.system(size: 13, design: .rounded))
                                            .foregroundColor(AppTheme.Palette.bark.opacity(0.7))
                                            .lineLimit(2)
                                    }
                                    Spacer()
                                    IcoChevronDown(sz: 16, tint: AppTheme.Palette.bark)
                                        .rotationEffect(.degrees(-90))
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
        .sheet(item: $selectedBait) { bait in
            BaitDetailSheet(bait: bait)
        }
    }
}

// Make BaitMaterial conform to Identifiable for sheet binding
extension BaitMaterial: Equatable {}

// MARK: - Bait Detail Sheet

struct BaitDetailSheet: View {
    let bait: BaitMaterial
    @Environment(\.presentationMode) var dismiss

    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.Palette.parchment.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Header with rating
                        WoodCard {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(bait.rawValue)
                                        .font(.system(size: 24, weight: .heavy, design: .rounded))
                                        .foregroundColor(AppTheme.Palette.charcoal)
                                    HStack(spacing: 2) {
                                        ForEach(1...5, id: \.self) { i in
                                            IcoStar(sz: 18, filled: i <= bait.effectivenessRating, tint: AppTheme.Palette.warmOrange)
                                        }
                                        Text("(\(bait.effectivenessRating)/5)")
                                            .font(.system(size: 13, design: .rounded))
                                            .foregroundColor(AppTheme.Palette.bark.opacity(0.6))
                                    }
                                }
                                Spacer()
                                IcoWorm(sz: 36, tint: AppTheme.Palette.dustyRed)
                            }
                        }

                        // Description
                        sectionCard(title: "Description") {
                            Text(bait.encyclopediaDescription)
                                .font(.system(size: 15, design: .rounded))
                                .foregroundColor(AppTheme.Palette.charcoal)
                                .lineSpacing(4)
                        }

                        // Best Target Species
                        sectionCard(title: "Best Target Species") {
                            FlowLayoutV2(items: bait.topSpecies, spacing: 6) { sp in
                                Text(sp.rawValue)
                                    .font(.system(size: 13, weight: .medium, design: .rounded))
                                    .foregroundColor(AppTheme.Palette.charcoal)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Capsule().fill(AppTheme.Palette.wheat))
                            }
                        }

                        // Best Seasons
                        sectionCard(title: "Best Seasons") {
                            HStack(spacing: 8) {
                                ForEach(bait.bestSeasons, id: \.self) { season in
                                    Text(season)
                                        .font(.system(size: 13, weight: .medium, design: .rounded))
                                        .foregroundColor(AppTheme.Palette.cream)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(Capsule().fill(AppTheme.Palette.forestGreen))
                                }
                            }
                        }

                        // Water Temp Range
                        sectionCard(title: "Water Temperature Range") {
                            Text(bait.waterTempRange)
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(AppTheme.Palette.bark)
                        }

                        // Presentation
                        sectionCard(title: "Presentation Technique") {
                            Text(bait.presentationTechnique)
                                .font(.system(size: 15, design: .rounded))
                                .foregroundColor(AppTheme.Palette.charcoal)
                                .lineSpacing(4)
                        }

                        // Storage
                        sectionCard(title: "Storage Advice") {
                            Text(bait.keepingAdvice)
                                .font(.system(size: 15, design: .rounded))
                                .foregroundColor(AppTheme.Palette.charcoal)
                                .lineSpacing(4)
                        }

                        // Peak Season
                        sectionCard(title: "Seasonal Peak") {
                            Text(bait.seasonalPeak)
                                .font(.system(size: 15, design: .rounded))
                                .foregroundColor(AppTheme.Palette.charcoal)
                        }
                    }
                    .padding(AppTheme.Spacing.md)
                }
            }
            .navigationTitle(bait.rawValue)
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
