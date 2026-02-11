import Foundation

// Bait amount calculator (stateless helper)
struct BaitCalculator {
    struct Breakdown {
        let baseAmount: Double      // base rate per hour per hole
        let perHourTotal: Double    // base * hours
        let perHoleAdjustment: Double // additional for multiple holes
        let speciesFactor: Double   // multiplier for species appetite
        let startFeed: Double       // initial feeding amount
        let hourlyFeed: Double      // ongoing feed per hour
        let total: Double           // grand total

        var speciesFactorLabel: String {
            if speciesFactor >= 1.3 { return "Heavy feeder" }
            if speciesFactor >= 1.0 { return "Normal feeder" }
            if speciesFactor >= 0.7 { return "Light feeder" }
            return "Minimal bait"
        }
    }

    static func estimate(species: FishSpecies, material: BaitMaterial, hours: Int, holes: Int) -> (total: Double, start: Double, hourly: Double) {
        let base = material.rateFor(species)
        let startFeed = base * Double(holes) * 1.5
        let hourlyFeed = base * Double(holes)
        let total = startFeed + hourlyFeed * Double(max(hours - 1, 0))
        return (total, startFeed, hourlyFeed)
    }

    static func detailedBreakdown(species: FishSpecies, material: BaitMaterial, hours: Int, holes: Int) -> Breakdown {
        let baseRate = material.rateFor(species)
        let factor = species.speciesFactor
        let adjustedBase = baseRate * factor

        let startFeed = adjustedBase * Double(holes) * 1.5
        let hourlyFeed = adjustedBase * Double(holes)
        let total = startFeed + hourlyFeed * Double(max(hours - 1, 0))

        let perHourRaw = adjustedBase * Double(hours)
        let holeAdj = adjustedBase * Double(max(holes - 1, 0)) * Double(hours) * 0.5

        return Breakdown(
            baseAmount: baseRate,
            perHourTotal: perHourRaw,
            perHoleAdjustment: holeAdj,
            speciesFactor: factor,
            startFeed: startFeed,
            hourlyFeed: hourlyFeed,
            total: total
        )
    }
}
