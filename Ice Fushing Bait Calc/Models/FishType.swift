import Foundation

enum FishType: String, CaseIterable, Codable, Identifiable {
    case perch = "Perch"
    case roach = "Roach"
    case bream = "Bream"
    case crucian = "Crucian Carp"
    case pike = "Pike"
    case rudd = "Rudd"
    case ide = "Ide"
    case tench = "Tench"
    case whitefish = "Whitefish"
    case burbot = "Burbot"
    
    var id: String { rawValue }
    
    var baseRates: [BaitType: Double] {
        switch self {
        case .perch:
            return [.bloodworm: 8, .maggot: 6, .plant: 3, .combined: 5]
        case .roach:
            return [.bloodworm: 10, .maggot: 8, .plant: 6, .combined: 7]
        case .bream:
            return [.bloodworm: 15, .maggot: 12, .plant: 10, .combined: 12]
        case .crucian:
            return [.bloodworm: 12, .maggot: 10, .plant: 8, .combined: 9]
        case .pike:
            return [.bloodworm: 5, .maggot: 4, .plant: 2, .combined: 3]
        case .rudd:
            return [.bloodworm: 9, .maggot: 7, .plant: 5, .combined: 6]
        case .ide:
            return [.bloodworm: 11, .maggot: 9, .plant: 7, .combined: 8]
        case .tench:
            return [.bloodworm: 14, .maggot: 11, .plant: 9, .combined: 11]
        case .whitefish:
            return [.bloodworm: 7, .maggot: 5, .plant: 4, .combined: 5]
        case .burbot:
            return [.bloodworm: 6, .maggot: 5, .plant: 3, .combined: 4]
        }
    }
    
    var description: String {
        switch self {
        case .perch:
            return "Aggressive predator, responds well to live bait"
        case .roach:
            return "Active feeder, prefers bloodworm in winter"
        case .bream:
            return "Bottom feeder, needs generous baiting"
        case .crucian:
            return "Cautious fish, moderate feeding required"
        case .pike:
            return "Predator, minimal bait needed"
        case .rudd:
            return "Surface feeder, light baiting works best"
        case .ide:
            return "Strong fighter, responds to varied bait"
        case .tench:
            return "Slow feeder, prefers plant-based bait"
        case .whitefish:
            return "Cold water species, light baiting"
        case .burbot:
            return "Night feeder, minimal bait needed"
        }
    }
}
