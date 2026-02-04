import Foundation

class StorageService {
    static let shared = StorageService()
    
    private let profilesKey = "bait_profiles"
    private let historyKey = "calculation_history"
    
    private init() {}
    
    // MARK: - Profiles
    
    func saveProfiles(_ profiles: [BaitProfile]) {
        if let data = try? JSONEncoder().encode(profiles) {
            UserDefaults.standard.set(data, forKey: profilesKey)
        }
    }
    
    func loadProfiles() -> [BaitProfile] {
        guard let data = UserDefaults.standard.data(forKey: profilesKey),
              let profiles = try? JSONDecoder().decode([BaitProfile].self, from: data) else {
            return []
        }
        return profiles
    }
    
    func addProfile(_ profile: BaitProfile) {
        var profiles = loadProfiles()
        profiles.append(profile)
        saveProfiles(profiles)
    }
    
    func updateProfile(_ profile: BaitProfile) {
        var profiles = loadProfiles()
        if let index = profiles.firstIndex(where: { $0.id == profile.id }) {
            profiles[index] = profile
            saveProfiles(profiles)
        }
    }
    
    func deleteProfile(_ profile: BaitProfile) {
        var profiles = loadProfiles()
        profiles.removeAll { $0.id == profile.id }
        saveProfiles(profiles)
    }
    
    // MARK: - History
    
    func saveHistory(_ entries: [HistoryEntry]) {
        if let data = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(data, forKey: historyKey)
        }
    }
    
    func loadHistory() -> [HistoryEntry] {
        guard let data = UserDefaults.standard.data(forKey: historyKey),
              let entries = try? JSONDecoder().decode([HistoryEntry].self, from: data) else {
            return []
        }
        return entries.sorted { $0.createdAt > $1.createdAt }
    }
    
    func addHistoryEntry(_ entry: HistoryEntry) {
        var entries = loadHistory()
        entries.insert(entry, at: 0)
        saveHistory(entries)
    }
    
    func updateHistoryEntry(_ entry: HistoryEntry) {
        var entries = loadHistory()
        if let index = entries.firstIndex(where: { $0.id == entry.id }) {
            entries[index] = entry
            saveHistory(entries)
        }
    }
    
    func deleteHistoryEntry(_ entry: HistoryEntry) {
        var entries = loadHistory()
        entries.removeAll { $0.id == entry.id }
        saveHistory(entries)
    }
    
    func clearHistory() {
        saveHistory([])
    }
}
