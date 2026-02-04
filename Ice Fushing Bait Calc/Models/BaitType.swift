import Foundation

enum BaitType: String, CaseIterable, Codable, Identifiable {
    case bloodworm = "Bloodworm"
    case maggot = "Maggot"
    case plant = "Plant-based"
    case combined = "Combined"
    
    var id: String { rawValue }
    
    var shortDescription: String {
        switch self {
        case .bloodworm:
            return "Live larvae, best for cold water"
        case .maggot:
            return "Versatile, works in most conditions"
        case .plant:
            return "Bread, dough, cereals mix"
        case .combined:
            return "Mix of live and plant bait"
        }
    }
    
    var storageInfo: String {
        switch self {
        case .bloodworm:
            return "Keep refrigerated at 2-4°C. Wrap in damp cloth or newspaper. Stays fresh for 3-5 days. Do not freeze."
        case .maggot:
            return "Store in sawdust at 4-6°C. Can last up to 2 weeks refrigerated. Keep container ventilated."
        case .plant:
            return "Prepare fresh or keep dry ingredients separate. Mix on-site for best results. Sealed containers work best."
        case .combined:
            return "Prepare live components separately. Mix just before fishing for optimal freshness and attraction."
        }
    }
    
    var bestFor: [FishType] {
        switch self {
        case .bloodworm:
            return [.perch, .roach, .bream]
        case .maggot:
            return [.roach, .crucian, .rudd]
        case .plant:
            return [.bream, .tench, .crucian]
        case .combined:
            return [.ide, .roach, .bream]
        }
    }
    
    var usageTips: String {
        switch self {
        case .bloodworm:
            return "Most effective in early winter and late winter. Drop in small portions to create a feeding column. Excellent for attracting fish from distance."
        case .maggot:
            return "Works year-round but best in mid-winter. Can be colored for visibility. Mix sizes for varied attraction."
        case .plant:
            return "Best when water temperature rises. Add flavoring for enhanced attraction. Form loose balls that break apart slowly."
        case .combined:
            return "Ideal for uncertain conditions. Start with more live bait, adjust based on fish response. Most versatile option."
        }
    }
}
