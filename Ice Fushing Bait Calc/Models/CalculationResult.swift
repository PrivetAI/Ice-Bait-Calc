import Foundation

struct CalculationResult: Codable, Identifiable {
    let id: UUID
    let fishType: FishType
    let baitType: BaitType
    let hours: Int
    let holes: Int
    let totalBait: Double
    let startFeed: Double
    let hourlyFeed: Double
    let calculatedAt: Date
    
    init(
        id: UUID = UUID(),
        fishType: FishType,
        baitType: BaitType,
        hours: Int,
        holes: Int,
        totalBait: Double,
        startFeed: Double,
        hourlyFeed: Double,
        calculatedAt: Date = Date()
    ) {
        self.id = id
        self.fishType = fishType
        self.baitType = baitType
        self.hours = hours
        self.holes = holes
        self.totalBait = totalBait
        self.startFeed = startFeed
        self.hourlyFeed = hourlyFeed
        self.calculatedAt = calculatedAt
    }
    
    var matchboxes: Double {
        totalBait / 20.0
    }
    
    var cups: Double {
        totalBait / 150.0
    }
    
    var visualEquivalent: String {
        if totalBait < 30 {
            return "About 1-2 matchboxes"
        } else if totalBait < 75 {
            return "About \(Int(matchboxes.rounded())) matchboxes"
        } else if totalBait < 150 {
            return "About half a cup"
        } else if totalBait < 300 {
            return "About \(Int(cups.rounded())) cup(s)"
        } else {
            return "About \(Int(cups.rounded())) cups"
        }
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: calculatedAt)
    }
}
