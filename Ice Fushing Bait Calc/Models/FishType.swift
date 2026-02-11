import Foundation

enum FishSpecies: String, CaseIterable, Codable, Identifiable {
    case perch = "Perch"
    case roach = "Roach"
    case bream = "Bream"
    case crucian = "Crucian Carp"
    case pike = "Pike"
    case walleye = "Walleye"
    case trout = "Trout"
    case burbot = "Burbot"
    case whitefish = "Whitefish"
    case ruffe = "Ruffe"
    case rudd = "Rudd"
    case ide = "Ide"
    case tench = "Tench"

    var id: String { rawValue }

    var consumptionRates: [BaitMaterial: Double] {
        switch self {
        case .perch:     return [.bloodworm: 8, .maggot: 6, .breadDough: 3, .mixedLive: 5, .mealworm: 7, .waxWorm: 6, .corn: 2, .artificialLure: 1, .minnow: 4, .doughBall: 3, .cheeseBait: 2, .redWiggler: 7]
        case .roach:     return [.bloodworm: 10, .maggot: 8, .breadDough: 6, .mixedLive: 7, .mealworm: 5, .waxWorm: 4, .corn: 5, .artificialLure: 1, .minnow: 2, .doughBall: 5, .cheeseBait: 4, .redWiggler: 8]
        case .bream:     return [.bloodworm: 15, .maggot: 12, .breadDough: 10, .mixedLive: 12, .mealworm: 8, .waxWorm: 6, .corn: 9, .artificialLure: 1, .minnow: 3, .doughBall: 10, .cheeseBait: 8, .redWiggler: 10]
        case .crucian:   return [.bloodworm: 12, .maggot: 10, .breadDough: 8, .mixedLive: 9, .mealworm: 6, .waxWorm: 5, .corn: 7, .artificialLure: 1, .minnow: 2, .doughBall: 8, .cheeseBait: 6, .redWiggler: 8]
        case .pike:      return [.bloodworm: 5, .maggot: 4, .breadDough: 2, .mixedLive: 3, .mealworm: 3, .waxWorm: 2, .corn: 1, .artificialLure: 2, .minnow: 8, .doughBall: 1, .cheeseBait: 1, .redWiggler: 4]
        case .walleye:   return [.bloodworm: 6, .maggot: 5, .breadDough: 2, .mixedLive: 4, .mealworm: 5, .waxWorm: 3, .corn: 1, .artificialLure: 2, .minnow: 7, .doughBall: 2, .cheeseBait: 2, .redWiggler: 5]
        case .trout:     return [.bloodworm: 7, .maggot: 6, .breadDough: 3, .mixedLive: 5, .mealworm: 7, .waxWorm: 5, .corn: 3, .artificialLure: 2, .minnow: 5, .doughBall: 3, .cheeseBait: 2, .redWiggler: 7]
        case .burbot:    return [.bloodworm: 6, .maggot: 5, .breadDough: 3, .mixedLive: 4, .mealworm: 4, .waxWorm: 3, .corn: 2, .artificialLure: 1, .minnow: 6, .doughBall: 3, .cheeseBait: 3, .redWiggler: 5]
        case .whitefish:  return [.bloodworm: 7, .maggot: 5, .breadDough: 4, .mixedLive: 5, .mealworm: 6, .waxWorm: 5, .corn: 3, .artificialLure: 1, .minnow: 3, .doughBall: 4, .cheeseBait: 3, .redWiggler: 6]
        case .ruffe:     return [.bloodworm: 9, .maggot: 7, .breadDough: 4, .mixedLive: 6, .mealworm: 5, .waxWorm: 6, .corn: 2, .artificialLure: 1, .minnow: 3, .doughBall: 3, .cheeseBait: 2, .redWiggler: 7]
        case .rudd:      return [.bloodworm: 9, .maggot: 7, .breadDough: 5, .mixedLive: 6, .mealworm: 4, .waxWorm: 4, .corn: 4, .artificialLure: 1, .minnow: 2, .doughBall: 5, .cheeseBait: 3, .redWiggler: 7]
        case .ide:       return [.bloodworm: 11, .maggot: 9, .breadDough: 7, .mixedLive: 8, .mealworm: 6, .waxWorm: 4, .corn: 5, .artificialLure: 1, .minnow: 4, .doughBall: 6, .cheeseBait: 5, .redWiggler: 8]
        case .tench:     return [.bloodworm: 14, .maggot: 11, .breadDough: 9, .mixedLive: 11, .mealworm: 7, .waxWorm: 5, .corn: 8, .artificialLure: 1, .minnow: 2, .doughBall: 9, .cheeseBait: 7, .redWiggler: 9]
        }
    }

    var note: String {
        switch self {
        case .perch:     return "Aggressive predator, responds to live bait"
        case .roach:     return "Active feeder under ice, loves bloodworm"
        case .bream:     return "Bottom dweller, needs generous baiting"
        case .crucian:   return "Cautious biter, moderate feeding"
        case .pike:      return "Apex predator, minimal bait required"
        case .walleye:   return "Deep-water hunter, prefers minnows and lures"
        case .trout:     return "Cold-water specialist, active and selective feeder"
        case .burbot:    return "Nocturnal feeder, small amounts suffice"
        case .whitefish:  return "Cold-water lover, use light portions"
        case .ruffe:     return "Bottom-dwelling micro-predator, aggressive biter"
        case .rudd:      return "Surface oriented, keep bait light"
        case .ide:       return "Strong fighter, varied bait works well"
        case .tench:     return "Slow feeder, prefers plant mixes"
        }
    }

    var speciesDescription: String {
        switch self {
        case .perch:
            return "European perch are one of the most popular ice fishing targets. They form schools near underwater structures and are aggressive biters, especially during early and late ice. Their distinctive striped pattern makes them easy to identify."
        case .roach:
            return "Roach are prolific feeders that remain active throughout winter. They school in large numbers at various depths and respond well to regular feeding. Patient anglers can catch impressive quantities once a school is located."
        case .bream:
            return "Bream are the giants of bottom feeding under ice. They require patience and generous feeding to attract, but once a school settles over your feeding spot, the action can be outstanding. They prefer deeper, calmer areas."
        case .crucian:
            return "Crucian carp are cautious and deliberate biters known for their subtle takes. They prefer sheltered, weedy areas and shallow bays. Catching crucian through ice requires finesse and patience but is deeply rewarding."
        case .pike:
            return "Northern pike are the apex predators of frozen lakes. They ambush prey near weed edges and drop-offs. Ice fishing for pike typically involves tip-ups with live or dead bait fish. Expect powerful strikes and long runs."
        case .walleye:
            return "Walleye are prized for their excellent table quality and challenging fight. They inhabit deep, clear lakes and are most active during low-light periods. Dawn and dusk are prime times for walleye through the ice."
        case .trout:
            return "Trout species including rainbow, brown, and brook trout provide exciting ice fishing in cold, well-oxygenated waters. They are selective feeders that respond to natural presentations. Light tackle and subtle jigging are key."
        case .burbot:
            return "Burbot are the only freshwater cod and are uniquely adapted to ice-cold water. They spawn under the ice in mid-winter and become most active at night. Target them in deep water near rocky bottoms after dark."
        case .whitefish:
            return "Whitefish are delicate-mouthed cold-water fish that provide a technical challenge for ice anglers. They feed on small invertebrates in deep water and require light tackle and tiny hooks to detect their gentle bites."
        case .ruffe:
            return "Ruffe are small but voracious bottom-dwelling perch relatives. They bite aggressively on bloodworm and small larvae baits. While individually small, they provide fast action and are excellent for beginners learning ice fishing."
        case .rudd:
            return "Rudd are surface-oriented fish that can be caught through ice in shallow, weedy areas. They share habitat with roach but prefer slightly warmer, shallower water. Golden-scaled and attractive, they fight well for their size."
        case .ide:
            return "Ide are powerful cyprinids that put up excellent fights when hooked. They feed in schools near moderate depths and respond to a wide variety of baits. They are particularly active during late ice as spring approaches."
        case .tench:
            return "Tench are bottom-dwelling fish that prefer muddy, weedy environments. They are uncommon catches through ice but can be targeted in shallow bays during late ice. Their thick mucus coating and olive-green color are distinctive."
        }
    }

    var preferredBaits: [BaitMaterial] {
        switch self {
        case .perch:     return [.bloodworm, .mealworm, .redWiggler, .waxWorm]
        case .roach:     return [.bloodworm, .maggot, .redWiggler]
        case .bream:     return [.bloodworm, .maggot, .breadDough, .mixedLive]
        case .crucian:   return [.bloodworm, .maggot, .breadDough, .corn]
        case .pike:      return [.minnow, .artificialLure]
        case .walleye:   return [.minnow, .artificialLure, .mealworm]
        case .trout:     return [.mealworm, .redWiggler, .bloodworm, .waxWorm]
        case .burbot:    return [.minnow, .bloodworm, .redWiggler]
        case .whitefish:  return [.mealworm, .bloodworm, .waxWorm]
        case .ruffe:     return [.bloodworm, .waxWorm, .redWiggler]
        case .rudd:      return [.bloodworm, .maggot, .redWiggler]
        case .ide:       return [.bloodworm, .maggot, .mixedLive]
        case .tench:     return [.bloodworm, .breadDough, .mixedLive, .doughBall]
        }
    }

    var bestTimeOfDay: String {
        switch self {
        case .perch:     return "Morning and late afternoon"
        case .roach:     return "Mid-morning through early afternoon"
        case .bream:     return "Early morning and evening"
        case .crucian:   return "Late morning to mid-afternoon"
        case .pike:      return "Dawn and dusk, overcast days"
        case .walleye:   return "Dawn, dusk, and after dark"
        case .trout:     return "Early morning, all day in overcast"
        case .burbot:    return "Night, especially late evening"
        case .whitefish:  return "Mid-morning to early afternoon"
        case .ruffe:     return "Late afternoon into evening"
        case .rudd:      return "Mid-day when sun warms shallows"
        case .ide:       return "Morning and late afternoon"
        case .tench:     return "Late morning, warm afternoons"
        }
    }

    var habitatPreferences: String {
        switch self {
        case .perch:     return "Near underwater structures, weed edges, and drop-offs at 2-6m depth"
        case .roach:     return "Open water areas at 3-8m depth, near bottom or mid-water"
        case .bream:     return "Deep, flat muddy bottoms at 4-10m depth, calm areas"
        case .crucian:   return "Shallow weedy bays at 1-3m depth, sheltered from current"
        case .pike:      return "Weed edges, drop-offs, and ambush points at 2-8m depth"
        case .walleye:   return "Deep clear water at 5-15m, near rocky points and reefs"
        case .trout:     return "Cold, well-oxygenated water at 3-10m, near springs or inflows"
        case .burbot:    return "Deep rocky bottoms at 5-15m, near underwater structure"
        case .whitefish:  return "Deep open water at 8-20m, suspended above bottom"
        case .ruffe:     return "Sandy or gravel bottoms at 2-6m depth, near structure"
        case .rudd:      return "Shallow weedy areas at 1-3m, near reed beds"
        case .ide:       return "Moderate depth at 3-7m, near current areas and inflows"
        case .tench:     return "Muddy, weedy shallows at 1-4m, quiet bays"
        }
    }

    var averageSizeIceFishing: String {
        switch self {
        case .perch:     return "150-400g (6-14 oz)"
        case .roach:     return "100-300g (4-11 oz)"
        case .bream:     return "500-2000g (1-4.5 lb)"
        case .crucian:   return "200-600g (7-21 oz)"
        case .pike:      return "2-8 kg (4.5-18 lb)"
        case .walleye:   return "1-4 kg (2-9 lb)"
        case .trout:     return "300-1500g (11 oz-3.3 lb)"
        case .burbot:    return "500-3000g (1-6.5 lb)"
        case .whitefish:  return "300-1000g (11 oz-2.2 lb)"
        case .ruffe:     return "30-100g (1-3.5 oz)"
        case .rudd:      return "100-300g (4-11 oz)"
        case .ide:       return "300-1200g (11 oz-2.6 lb)"
        case .tench:     return "300-1500g (11 oz-3.3 lb)"
        }
    }

    var catchingTips: String {
        switch self {
        case .perch:     return "Use bright-colored lures or bloodworm. Jig aggressively to attract, then slow down. Fish near structures and vary depth until you find the school."
        case .roach:     return "Feed small amounts of bloodworm regularly to hold the school. Use tiny hooks and be ready for subtle bites. Keep your bait near the bottom."
        case .bream:     return "Pre-feed heavily the day before if possible. Use a sensitive float or nod rod. Bream bites are lift bites — the float rises rather than sinks."
        case .crucian:   return "Use extremely light tackle and small hooks. Crucian bites are barely detectable. Fish shallow weedy areas and be patient between bites."
        case .pike:      return "Set tip-ups with live minnows at various depths. Check local regulations on hook types. Use a wire leader to prevent bite-offs."
        case .walleye:   return "Fish deep structure at dawn and dusk. Use jigging spoons tipped with minnow heads. Walleye have excellent night vision — glow lures work in deep water."
        case .trout:     return "Use light 2-4 lb line and small hooks. Present bait naturally with minimal weight. Trout are line-shy so use fluorocarbon in clear water."
        case .burbot:    return "Fish after dark on rocky bottoms. Use dead minnows or cut bait on bottom rigs. Burbot are not finicky — strong scent works well."
        case .whitefish:  return "Use tiny hooks (#16-#20) with single maggots or small worms. Very sensitive bites require spring bobber or ultra-light nod rod."
        case .ruffe:     return "Drop bloodworm or small worms to the bottom. Ruffe bite aggressively and often self-hook. Great species for keeping children engaged."
        case .rudd:      return "Fish higher in the water column near weed beds. Use small bloodworm or maggot on tiny hooks. Best during mild, sunny winter days."
        case .ide:       return "Feed regularly with mixed bait. Use medium tackle as ide fight hard. They often feed in short windows so be ready when the school arrives."
        case .tench:     return "Target warm-water bays during late ice. Use bread or dough baits on bottom. Very patient fishing — expect long waits between bites."
        }
    }

    // Species factor for bait calculator (multiplier)
    var speciesFactor: Double {
        switch self {
        case .bream, .tench: return 1.4
        case .crucian, .ide: return 1.2
        case .roach, .rudd, .ruffe: return 1.0
        case .perch, .whitefish, .trout: return 0.8
        case .pike, .walleye: return 0.5
        case .burbot: return 0.6
        }
    }
}

typealias FishType = FishSpecies
