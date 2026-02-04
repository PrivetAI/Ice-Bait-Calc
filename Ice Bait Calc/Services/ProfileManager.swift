import Foundation
import SwiftUI

class ProfileManager: ObservableObject {
    static let shared = ProfileManager()
    
    @Published var profiles: [BaitProfile] = []
    @Published var history: [HistoryEntry] = []
    
    private let storage = StorageService.shared
    
    private init() {
        loadData()
    }
    
    func loadData() {
        profiles = storage.loadProfiles()
        history = storage.loadHistory()
    }
    
    // MARK: - Profiles
    
    func addProfile(_ profile: BaitProfile) {
        profiles.append(profile)
        storage.saveProfiles(profiles)
    }
    
    func updateProfile(_ profile: BaitProfile) {
        if let index = profiles.firstIndex(where: { $0.id == profile.id }) {
            profiles[index] = profile
            storage.saveProfiles(profiles)
        }
    }
    
    func deleteProfile(_ profile: BaitProfile) {
        profiles.removeAll { $0.id == profile.id }
        storage.saveProfiles(profiles)
    }
    
    func deleteProfile(at offsets: IndexSet) {
        profiles.remove(atOffsets: offsets)
        storage.saveProfiles(profiles)
    }
    
    // MARK: - History
    
    func addToHistory(_ result: CalculationResult) {
        let entry = HistoryEntry(result: result)
        history.insert(entry, at: 0)
        storage.saveHistory(history)
    }
    
    func updateHistoryEntry(_ entry: HistoryEntry) {
        if let index = history.firstIndex(where: { $0.id == entry.id }) {
            history[index] = entry
            storage.saveHistory(history)
        }
    }
    
    func deleteHistoryEntry(_ entry: HistoryEntry) {
        history.removeAll { $0.id == entry.id }
        storage.saveHistory(history)
    }
    
    func deleteHistoryEntry(at offsets: IndexSet) {
        history.remove(atOffsets: offsets)
        storage.saveHistory(history)
    }
    
    func clearHistory() {
        history.removeAll()
        storage.saveHistory(history)
    }
}
