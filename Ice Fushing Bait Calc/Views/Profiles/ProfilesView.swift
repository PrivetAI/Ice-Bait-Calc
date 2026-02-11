import SwiftUI

// Recipes section — collapsible list of saved bait recipes
struct RecipeSectionView: View {
    @ObservedObject var state: AppState
    @Binding var expanded: Bool
    @State private var showComposer = false
    @State private var editingRecipe: BaitRecipe?

    var body: some View {
        VStack(spacing: 0) {
            Button(action: { withAnimation(.easeInOut(duration: 0.25)) { expanded.toggle() } }) {
                HStack {
                    IcoWorm(sz: 22, tint: AppTheme.Palette.warmOrange)
                    Text("Bait Recipes")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(AppTheme.Palette.charcoal)
                    Spacer()
                    Text("\(state.recipes.count)")
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundColor(AppTheme.Palette.cream)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Capsule().fill(AppTheme.Palette.warmOrange))
                    IcoChevronDown(sz: 18, tint: AppTheme.Palette.bark)
                        .rotationEffect(.degrees(expanded ? 0 : -90))
                }
                .padding(.vertical, AppTheme.Spacing.sm)
            }
            .buttonStyle(PlainButtonStyle())

            if expanded {
                VStack(spacing: 10) {
                    RusticButton(label: "New Recipe", action: { showComposer = true }, tone: .primary)

                    if state.recipes.isEmpty {
                        Text("Save your favorite bait combinations here for quick reference.")
                            .font(.system(size: 14, design: .rounded))
                            .foregroundColor(AppTheme.Palette.bark.opacity(0.7))
                            .multilineTextAlignment(.center)
                            .padding(.vertical, AppTheme.Spacing.lg)
                    } else {
                        ForEach(state.recipes) { recipe in
                            RecipeRow(recipe: recipe, onEdit: { editingRecipe = recipe }, onDelete: { state.removeRecipe(recipe) })
                        }
                    }
                }
                .padding(.top, AppTheme.Spacing.sm)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .sheet(isPresented: $showComposer) {
            RecipeComposerView(state: state, existing: nil)
        }
        .sheet(item: $editingRecipe) { recipe in
            RecipeComposerView(state: state, existing: recipe)
        }
    }
}

struct RecipeRow: View {
    let recipe: BaitRecipe
    let onEdit: () -> Void
    let onDelete: () -> Void
    @State private var confirmDelete = false

    var body: some View {
        WoodCard {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(recipe.title)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(AppTheme.Palette.charcoal)
                    Text("\(recipe.species.rawValue) / \(recipe.material.rawValue)")
                        .font(.system(size: 13, design: .rounded))
                        .foregroundColor(AppTheme.Palette.bark.opacity(0.7))
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    Text("\(Int(recipe.totalGrams)) g")
                        .font(.system(size: 18, weight: .heavy, design: .rounded))
                        .foregroundColor(AppTheme.Palette.warmOrange)
                    StarDisplayView(rating: recipe.starRating, sz: 12)
                }
            }

            HStack(spacing: 14) {
                HStack(spacing: 4) {
                    IcoClock(sz: 14)
                    Text("\(recipe.durationHours)h")
                        .font(.system(size: 12, design: .rounded))
                        .foregroundColor(AppTheme.Palette.bark.opacity(0.6))
                }
                HStack(spacing: 4) {
                    IcoHole(sz: 14)
                    Text("\(recipe.holeCount) holes")
                        .font(.system(size: 12, design: .rounded))
                        .foregroundColor(AppTheme.Palette.bark.opacity(0.6))
                }
                Spacer()
                Button(action: onEdit) {
                    Text("Edit")
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundColor(AppTheme.Palette.forestGreen)
                }
                Button(action: { confirmDelete = true }) {
                    IcoTrash(sz: 18)
                }
            }
        }
        .alert(isPresented: $confirmDelete) {
            Alert(
                title: Text("Delete Recipe"),
                message: Text("Remove \"\(recipe.title)\"?"),
                primaryButton: .destructive(Text("Delete"), action: onDelete),
                secondaryButton: .cancel()
            )
        }
    }
}
