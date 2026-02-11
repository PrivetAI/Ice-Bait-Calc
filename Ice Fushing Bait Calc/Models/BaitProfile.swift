import Foundation

// A journal entry — a fishing trip log where user records bait usage and rates it
struct JournalEntry: Codable, Identifiable {
    let id: UUID
    var species: FishSpecies
    var material: BaitMaterial
    var durationHours: Int
    var holeCount: Int
    var baitUsedGrams: Double       // actual amount used
    var effectiveness: Effectiveness
    var weatherTag: WeatherTag
    var memo: String
    var starRating: Int             // 1-5 subjective
    let loggedAt: Date
    var editedAt: Date

    init(
        id: UUID = UUID(),
        species: FishSpecies = .perch,
        material: BaitMaterial = .bloodworm,
        durationHours: Int = 4,
        holeCount: Int = 3,
        baitUsedGrams: Double = 0,
        effectiveness: Effectiveness = .okay,
        weatherTag: WeatherTag = .overcast,
        memo: String = "",
        starRating: Int = 3,
        loggedAt: Date = Date(),
        editedAt: Date = Date()
    ) {
        self.id = id
        self.species = species
        self.material = material
        self.durationHours = durationHours
        self.holeCount = holeCount
        self.baitUsedGrams = baitUsedGrams
        self.effectiveness = effectiveness
        self.weatherTag = weatherTag
        self.memo = memo
        self.starRating = min(5, max(1, starRating))
        self.loggedAt = loggedAt
        self.editedAt = editedAt
    }

    var formattedDate: String {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .short
        return f.string(from: loggedAt)
    }
}

enum Effectiveness: String, Codable, CaseIterable, Identifiable {
    case poor = "Poor"
    case okay = "Okay"
    case good = "Good"
    case great = "Great"
    var id: String { rawValue }
}

enum WeatherTag: String, Codable, CaseIterable, Identifiable {
    case sunny = "Sunny"
    case overcast = "Overcast"
    case snowy = "Snowy"
    case windy = "Windy"
    case foggy = "Foggy"
    var id: String { rawValue }
}
