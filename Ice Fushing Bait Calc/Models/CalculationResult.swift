import Foundation

// A saved bait recipe — a reusable combination of species + material + settings
struct BaitRecipe: Codable, Identifiable {
    let id: UUID
    var title: String
    var species: FishSpecies
    var material: BaitMaterial
    var durationHours: Int
    var holeCount: Int
    var personalNotes: String
    var starRating: Int          // 1-5
    var createdAt: Date
    var updatedAt: Date

    init(
        id: UUID = UUID(),
        title: String,
        species: FishSpecies,
        material: BaitMaterial,
        durationHours: Int = 4,
        holeCount: Int = 3,
        personalNotes: String = "",
        starRating: Int = 3,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.species = species
        self.material = material
        self.durationHours = durationHours
        self.holeCount = holeCount
        self.personalNotes = personalNotes
        self.starRating = min(5, max(1, starRating))
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    // Computed bait amounts
    var startFeed: Double {
        let base = material.rateFor(species)
        return base * Double(holeCount) * 1.5
    }

    var hourlyFeed: Double {
        material.rateFor(species) * Double(holeCount)
    }

    var totalGrams: Double {
        startFeed + hourlyFeed * Double(max(durationHours - 1, 0))
    }

    var portionDescription: String {
        let boxes = totalGrams / 20.0
        let cups = totalGrams / 150.0
        if totalGrams < 30 { return "1-2 matchboxes" }
        if totalGrams < 75 { return "\(Int(boxes.rounded())) matchboxes" }
        if totalGrams < 150 { return "About half a cup" }
        return "\(Int(cups.rounded())) cup(s)"
    }

    var formattedDate: String {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .short
        return f.string(from: createdAt)
    }
}
