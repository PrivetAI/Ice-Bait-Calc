import SwiftUI

// Knowledge / Tips section — collapsible
struct KnowledgeSectionView: View {
    @Binding var expanded: Bool
    @State private var selectedArticle: TipArticle?

    var body: some View {
        VStack(spacing: 0) {
            Button(action: { withAnimation(.easeInOut(duration: 0.25)) { expanded.toggle() } }) {
                HStack {
                    IcoFish(sz: 22, tint: AppTheme.Palette.forestGreen)
                    Text("Ice Fishing Tips")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(AppTheme.Palette.charcoal)
                    Spacer()
                    IcoChevronDown(sz: 18, tint: AppTheme.Palette.bark)
                        .rotationEffect(.degrees(expanded ? 0 : -90))
                }
                .padding(.vertical, AppTheme.Spacing.sm)
            }
            .buttonStyle(PlainButtonStyle())

            if expanded {
                VStack(spacing: 10) {
                    // Bait material cards
                    Group {
                        Text("Bait Materials")
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                            .foregroundColor(AppTheme.Palette.bark)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 4)

                        ForEach(BaitMaterial.allCases) { mat in
                            TipRow(title: mat.rawValue, subtitle: mat.briefNote) {
                                selectedArticle = TipArticle(
                                    title: mat.rawValue,
                                    sections: [
                                        ("Overview", mat.briefNote),
                                        ("Best Species", mat.topSpecies.map { $0.rawValue }.joined(separator: ", ")),
                                        ("Storage", mat.keepingAdvice),
                                        ("Peak Season", mat.seasonalPeak),
                                    ]
                                )
                            }
                        }
                    }

                    // Species cards
                    Group {
                        Text("Fish Species")
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                            .foregroundColor(AppTheme.Palette.bark)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 8)

                        ForEach(FishSpecies.allCases) { sp in
                            let bestMat = sp.consumptionRates.max(by: { $0.value < $1.value })?.key ?? .bloodworm
                            TipRow(title: sp.rawValue, subtitle: sp.note) {
                                selectedArticle = TipArticle(
                                    title: sp.rawValue,
                                    sections: [
                                        ("About", sp.note),
                                        ("Best Bait", bestMat.rawValue),
                                        ("Consumption (g/hr/hole)",
                                         BaitMaterial.allCases.map { m in
                                             "\(m.rawValue): \(Int(sp.consumptionRates[m] ?? 0))"
                                         }.joined(separator: "\n")),
                                    ]
                                )
                            }
                        }
                    }

                    // General tips
                    Group {
                        Text("Common Mistakes")
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                            .foregroundColor(AppTheme.Palette.bark)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 8)

                        TipRow(title: "Overfeeding", subtitle: "Why less is often more") {
                            selectedArticle = TipArticle(title: "Overfeeding", sections: [
                                ("The Problem", "Too much bait makes fish lazy. They stop biting your hook when surrounded by free food."),
                                ("Warning Signs", "Fish visible but not biting. Leftover bait in the hole. Activity drops after feeding."),
                                ("Prevention", "Start with calculated amounts. Watch fish behavior before adding more. Use small, frequent portions."),
                                ("Recovery", "If overfed, wait 30-60 minutes. Consider moving to a fresh hole."),
                            ])
                        }

                        TipRow(title: "Bad Timing", subtitle: "When to feed and when to pause") {
                            selectedArticle = TipArticle(title: "Timing", sections: [
                                ("Feed When", "Early morning first hour. After inactivity periods. When biting slows down."),
                                ("Skip When", "Fish are actively biting. Right after a feed. Extreme cold — reduce feeding."),
                                ("Rhythm", "Consistent schedule works best. Fish learn and anticipate regular feeding times."),
                                ("Weather Effect", "Falling pressure: feed more. Rising pressure: feed less. Stable: keep rhythm."),
                            ])
                        }

                        TipRow(title: "Poor Storage", subtitle: "Keep bait alive and effective") {
                            selectedArticle = TipArticle(title: "Storage", sections: [
                                ("Rules", "Cool but not frozen. Maintain moisture. Use breathable containers. No direct sun."),
                                ("On the Ice", "Inside jacket pocket. Insulated box. Away from the hole. Wind-protected."),
                                ("Spoilage Signs", "Bad smell. Color change. Reduced movement. Mushy texture."),
                            ])
                        }
                    }
                }
                .padding(.top, AppTheme.Spacing.sm)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .sheet(item: $selectedArticle) { article in
            ArticleSheet(article: article)
        }
    }
}

struct TipRow: View {
    let title: String
    let subtitle: String
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            WoodCard {
                HStack {
                    VStack(alignment: .leading, spacing: 3) {
                        Text(title)
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundColor(AppTheme.Palette.charcoal)
                        Text(subtitle)
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

struct TipArticle: Identifiable {
    let id = UUID()
    let title: String
    let sections: [(String, String)]
}
