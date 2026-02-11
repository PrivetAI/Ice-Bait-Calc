import Foundation

// Persistence layer — UserDefaults backed
final class Vault {
    static let shared = Vault()
    private init() {}

    private let journalKey = "vault_journal_entries_v2"
    private let recipeKey = "vault_bait_recipes_v2"

    // MARK: - Journal

    func loadJournal() -> [JournalEntry] {
        guard let data = UserDefaults.standard.data(forKey: journalKey),
              let list = try? JSONDecoder().decode([JournalEntry].self, from: data) else { return [] }
        return list.sorted { $0.loggedAt > $1.loggedAt }
    }

    func saveJournal(_ entries: [JournalEntry]) {
        if let data = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(data, forKey: journalKey)
        }
    }

    // MARK: - Recipes

    func loadRecipes() -> [BaitRecipe] {
        guard let data = UserDefaults.standard.data(forKey: recipeKey),
              let list = try? JSONDecoder().decode([BaitRecipe].self, from: data) else { return [] }
        return list.sorted { $0.createdAt > $1.createdAt }
    }

    func saveRecipes(_ recipes: [BaitRecipe]) {
        if let data = try? JSONEncoder().encode(recipes) {
            UserDefaults.standard.set(data, forKey: recipeKey)
        }
    }
}
