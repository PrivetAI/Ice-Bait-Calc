import Foundation
import SwiftUI

// Central app state — observable
final class AppState: ObservableObject {
    static let shared = AppState()

    @Published var journal: [JournalEntry] = []
    @Published var recipes: [BaitRecipe] = []

    private let vault = Vault.shared

    private init() { reload() }

    func reload() {
        journal = vault.loadJournal()
        recipes = vault.loadRecipes()
    }

    // MARK: - Journal CRUD

    func addJournalEntry(_ entry: JournalEntry) {
        journal.insert(entry, at: 0)
        vault.saveJournal(journal)
    }

    func updateJournalEntry(_ entry: JournalEntry) {
        if let idx = journal.firstIndex(where: { $0.id == entry.id }) {
            journal[idx] = entry
            vault.saveJournal(journal)
        }
    }

    func removeJournalEntry(_ entry: JournalEntry) {
        journal.removeAll { $0.id == entry.id }
        vault.saveJournal(journal)
    }

    func clearJournal() {
        journal.removeAll()
        vault.saveJournal(journal)
    }

    // MARK: - Recipe CRUD

    func addRecipe(_ recipe: BaitRecipe) {
        recipes.insert(recipe, at: 0)
        vault.saveRecipes(recipes)
    }

    func updateRecipe(_ recipe: BaitRecipe) {
        if let idx = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes[idx] = recipe
            vault.saveRecipes(recipes)
        }
    }

    func removeRecipe(_ recipe: BaitRecipe) {
        recipes.removeAll { $0.id == recipe.id }
        vault.saveRecipes(recipes)
    }
}
