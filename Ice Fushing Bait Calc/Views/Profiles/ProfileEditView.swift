import SwiftUI

// Recipe composer — sheet to create or edit a bait recipe
struct RecipeComposerView: View {
    @ObservedObject var state: AppState
    let existing: BaitRecipe?
    @Environment(\.presentationMode) var dismiss

    @State private var title: String = ""
    @State private var species: FishSpecies = .perch
    @State private var material: BaitMaterial = .bloodworm
    @State private var hours: Double = 4
    @State private var holes: Double = 3
    @State private var notes: String = ""
    @State private var stars: Int = 3

    var isEdit: Bool { existing != nil }

    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.Palette.parchment.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 14) {
                        // Title
                        WoodCard {
                            Text("Recipe Name")
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                                .foregroundColor(AppTheme.Palette.charcoal)
                            TextField("e.g. Deep Bream Blend", text: $title)
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(AppTheme.Palette.charcoal)
                                .padding(10)
                                .background(RoundedRectangle(cornerRadius: 8).fill(AppTheme.Palette.wheat.opacity(0.5)))
                        }

                        ChipPicker(heading: "Species", icon: AnyView(IcoFish(sz: 22)), items: FishSpecies.allCases, picked: $species)
                        ChipPicker(heading: "Bait Material", icon: AnyView(IcoWorm(sz: 22)), items: BaitMaterial.allCases, picked: $material)

                        RangeControl(heading: "Duration", value: $hours, bounds: 1...12, step: 1, icon: AnyView(IcoClock(sz: 22)), suffix: "hr")
                        RangeControl(heading: "Holes", value: $holes, bounds: 1...10, step: 1, icon: AnyView(IcoHole(sz: 22)), suffix: "holes")

                        // Calculated totals
                        estimateCard

                        WoodCard {
                            Text("Rating")
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                                .foregroundColor(AppTheme.Palette.charcoal)
                            StarRatingView(rating: $stars, sz: 32)
                        }

                        WoodCard {
                            Text("Personal Notes")
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                                .foregroundColor(AppTheme.Palette.charcoal)
                            TextEditor(text: $notes)
                                .frame(minHeight: 70)
                                .font(.system(size: 14, design: .rounded))
                                .foregroundColor(AppTheme.Palette.charcoal)
                                .padding(6)
                                .background(RoundedRectangle(cornerRadius: 8).fill(AppTheme.Palette.wheat.opacity(0.4)))
                                .cornerRadius(8)
                        }

                        RusticButton(label: isEdit ? "Update Recipe" : "Save Recipe", action: save)
                            .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                            .opacity(title.trimmingCharacters(in: .whitespaces).isEmpty ? 0.5 : 1)
                            .padding(.top, 6)
                    }
                    .padding(AppTheme.Spacing.md)
                }
            }
            .navigationTitle(isEdit ? "Edit Recipe" : "New Recipe")
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
        let est = BaitCalculator.estimate(species: species, material: material, hours: Int(hours), holes: Int(holes))
        return WoodCard {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Total Bait")
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundColor(AppTheme.Palette.bark.opacity(0.7))
                    Text("\(Int(est.total)) g")
                        .font(.system(size: 28, weight: .heavy, design: .rounded))
                        .foregroundColor(AppTheme.Palette.warmOrange)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 2) {
                    Text("Start: \(Int(est.start)) g")
                        .font(.system(size: 12, design: .rounded))
                        .foregroundColor(AppTheme.Palette.charcoal.opacity(0.7))
                    Text("Per hour: \(Int(est.hourly)) g")
                        .font(.system(size: 12, design: .rounded))
                        .foregroundColor(AppTheme.Palette.charcoal.opacity(0.7))
                }
            }
        }
    }

    private func loadExisting() {
        guard let r = existing else { return }
        title = r.title
        species = r.species
        material = r.material
        hours = Double(r.durationHours)
        holes = Double(r.holeCount)
        notes = r.personalNotes
        stars = r.starRating
    }

    private func save() {
        if isEdit, let old = existing {
            var u = old
            u.title = title
            u.species = species
            u.material = material
            u.durationHours = Int(hours)
            u.holeCount = Int(holes)
            u.personalNotes = notes
            u.starRating = stars
            u.updatedAt = Date()
            state.updateRecipe(u)
        } else {
            let r = BaitRecipe(
                title: title,
                species: species,
                material: material,
                durationHours: Int(hours),
                holeCount: Int(holes),
                personalNotes: notes,
                starRating: stars
            )
            state.addRecipe(r)
        }
        dismiss.wrappedValue.dismiss()
    }
}
