import Foundation

// Seasonal bait tips — static data shown in the seasonal calendar section
struct SeasonalTip: Identifiable {
    let id = UUID()
    let monthRange: String       // e.g. "Dec - Jan"
    let season: IceSeason
    let headline: String
    let body: String
    let recommendedMaterials: [BaitMaterial]
    let topSpecies: [FishSpecies]
}

enum IceSeason: String, CaseIterable, Identifiable {
    case earlyIce = "Early Ice"
    case midWinter = "Mid-Winter"
    case lateIce = "Late Ice"
    var id: String { rawValue }
}

// Pre-built tips
struct SeasonalTipStore {
    static let tips: [SeasonalTip] = [
        SeasonalTip(
            monthRange: "Nov - Dec",
            season: .earlyIce,
            headline: "First Ice Frenzy",
            body: "Fish are still active and aggressive. Use generous portions of bloodworm near drop-offs. Perch and roach feed heavily before deep winter sets in. Shorter sessions of 2-3 hours can be very productive.",
            recommendedMaterials: [.bloodworm, .mixedLive],
            topSpecies: [.perch, .roach, .ide]
        ),
        SeasonalTip(
            monthRange: "Jan - Feb",
            season: .midWinter,
            headline: "Deep Freeze Patience",
            body: "Metabolism slows. Use smaller bait portions and extend pauses between feeds. Maggot becomes more effective as bloodworm supply dwindles. Target deeper holes where fish congregate.",
            recommendedMaterials: [.maggot, .bloodworm],
            topSpecies: [.bream, .whitefish, .burbot]
        ),
        SeasonalTip(
            monthRange: "Mar - Apr",
            season: .lateIce,
            headline: "Spring Thaw Surge",
            body: "Oxygen levels rise under thinning ice. Fish become active again. Bread dough and mixed blends shine now. Feed more aggressively and try shallow areas near inflows.",
            recommendedMaterials: [.breadDough, .mixedLive, .maggot],
            topSpecies: [.crucian, .tench, .rudd]
        ),
    ]
}
