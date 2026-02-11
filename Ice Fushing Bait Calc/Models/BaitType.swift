import Foundation

// Bait materials used in ice fishing
enum BaitMaterial: String, CaseIterable, Codable, Identifiable {
    case bloodworm = "Bloodworm"
    case maggot = "Maggot"
    case breadDough = "Bread Dough"
    case mixedLive = "Mixed Live"
    case mealworm = "Mealworm"
    case waxWorm = "Wax Worm"
    case corn = "Corn"
    case artificialLure = "Artificial Lure"
    case minnow = "Minnow"
    case doughBall = "Dough Ball"
    case cheeseBait = "Cheese Bait"
    case redWiggler = "Red Wiggler"

    var id: String { rawValue }

    var briefNote: String {
        switch self {
        case .bloodworm: return "Cold-water larvae, top performer under ice"
        case .maggot: return "All-round, reliable in varied conditions"
        case .breadDough: return "Plant-based paste, great for bottom feeders"
        case .mixedLive: return "Blend of live and plant for versatility"
        case .mealworm: return "Hardy beetle larvae, stays active in cold water"
        case .waxWorm: return "Soft-bodied grub, irresistible to panfish"
        case .corn: return "Cheap and effective for carp and bream"
        case .artificialLure: return "Reusable synthetic bait, scented options available"
        case .minnow: return "Live or dead small fish for predators"
        case .doughBall: return "Moldable mix of flour and attractants"
        case .cheeseBait: return "Strong scent attracts fish from a distance"
        case .redWiggler: return "Earthworm variety, durable and lively on the hook"
        }
    }

    var keepingAdvice: String {
        switch self {
        case .bloodworm:
            return "Wrap in damp cloth, refrigerate 2-4 C. Lasts 3-5 days. Never freeze."
        case .maggot:
            return "Sawdust bed at 4-6 C. Ventilated lid. Good up to 2 weeks chilled."
        case .breadDough:
            return "Keep dry ingredients sealed. Mix on-site for peak freshness."
        case .mixedLive:
            return "Separate live components until use. Combine at the hole for best attraction."
        case .mealworm:
            return "Store in bran or oatmeal at 4-8 C. Can last weeks refrigerated. Avoid moisture buildup."
        case .waxWorm:
            return "Keep cool at 10-15 C, not refrigerated. Sawdust bedding. Use within 2 weeks for best results."
        case .corn:
            return "Canned corn keeps indefinitely sealed. Once opened, refrigerate and use within a week."
        case .artificialLure:
            return "Store dry in tackle box. Re-apply scent before each session. Inspect for damage regularly."
        case .minnow:
            return "Keep in aerated bucket with cold water. Change water often. Use within the day for live minnows."
        case .doughBall:
            return "Pre-mix dry ingredients at home. Add water on-site. Sealed bags keep dough soft for hours."
        case .cheeseBait:
            return "Wrap tightly in plastic. Strong smell is normal. Refrigerate between trips."
        case .redWiggler:
            return "Damp soil or peat moss at 10-15 C. Feed with coffee grounds. Lasts weeks with care."
        }
    }

    var seasonalPeak: String {
        switch self {
        case .bloodworm: return "Early winter and late winter"
        case .maggot: return "Mid-winter through early spring"
        case .breadDough: return "Late winter when water warms"
        case .mixedLive: return "Any season, strongest mid-winter"
        case .mealworm: return "Early ice and late ice when fish are active"
        case .waxWorm: return "Mid-winter, especially for panfish"
        case .corn: return "Late ice when bottom feeders become active"
        case .artificialLure: return "All season, especially effective early ice"
        case .minnow: return "Early ice for aggressive predators"
        case .doughBall: return "Late winter as water warms slightly"
        case .cheeseBait: return "Mid to late winter for bottom feeders"
        case .redWiggler: return "Early ice and late ice transition periods"
        }
    }

    var topSpecies: [FishSpecies] {
        switch self {
        case .bloodworm: return [.perch, .roach, .bream]
        case .maggot: return [.roach, .crucian, .rudd]
        case .breadDough: return [.bream, .tench, .crucian]
        case .mixedLive: return [.ide, .roach, .bream]
        case .mealworm: return [.perch, .trout, .whitefish]
        case .waxWorm: return [.perch, .ruffe, .whitefish]
        case .corn: return [.bream, .crucian, .roach]
        case .artificialLure: return [.pike, .walleye, .perch]
        case .minnow: return [.pike, .walleye, .burbot]
        case .doughBall: return [.bream, .crucian, .tench]
        case .cheeseBait: return [.bream, .crucian, .ide]
        case .redWiggler: return [.perch, .roach, .trout]
        }
    }

    var encyclopediaDescription: String {
        switch self {
        case .bloodworm:
            return "Bloodworms are the larvae of chironomid midges and are considered the premier ice fishing bait across Northern Europe and Russia. Their bright red color and natural scent trigger aggressive feeding responses even in the coldest water. They work best when threaded onto small hooks in bundles of 2-3 larvae."
        case .maggot:
            return "Maggots are the larvae of blowflies and are one of the most versatile ice fishing baits available. They stay active even in near-freezing water and can be dyed various colors for added attraction. Thread them through the blunt end to keep them wriggling on the hook."
        case .breadDough:
            return "Bread dough is a traditional plant-based bait made by mixing bread with water and sometimes honey or vanilla extract. It excels for bottom-feeding species that rely on scent. Form small balls around the hook and fish them near the bottom for best results."
        case .mixedLive:
            return "A mixed live bait approach combines bloodworms, maggots, and sometimes crushed plant matter into a potent feeding mixture. This cocktail approach triggers multiple senses and works when single-bait presentations fail. Layer components in the feeding hole for sustained attraction."
        case .mealworm:
            return "Mealworms are the larval form of the darkling beetle and are prized for their durability on the hook. They stay alive longer than most live baits in cold conditions and their natural oils release scent steadily underwater. Hook through the head for maximum wriggle action."
        case .waxWorm:
            return "Wax worms are the caterpillar larvae of the wax moth and are a favorite for panfish through the ice. Their soft, plump bodies are irresistible to smaller species. They are particularly effective when fish are being finicky during mid-winter cold snaps."
        case .corn:
            return "Sweet corn kernels are an underrated ice fishing bait that works exceptionally well for carp-family species. The bright yellow color provides visual attraction while the sweet scent draws fish from distance. Use 1-3 kernels on a small hook fished near the bottom."
        case .artificialLure:
            return "Artificial lures for ice fishing include scented soft plastics, jigging spoons, and tungsten jigs. They eliminate the hassle of keeping live bait fresh and can be tipped with natural attractants. Modern scented versions rival live bait effectiveness for active fish."
        case .minnow:
            return "Live or dead minnows are the go-to bait for targeting predatory fish through the ice. Small shiners, fathead minnows, or roach fry hooked through the back or lip provide natural swimming action. Dead minnows on tip-ups are a classic pike technique."
        case .doughBall:
            return "Dough balls are homemade bait formed from flour, cornmeal, and various attractants like garlic, anise, or cheese. They can be customized for target species and are very cost-effective. Adjust consistency so they stay on the hook but dissolve slowly to release scent."
        case .cheeseBait:
            return "Cheese-based baits leverage strong odor to attract fish through murky winter water. Processed cheese, Limburger, or homemade cheese-flour blends all work well. The scent travels far even in cold water. Best used near bottom structure where fish congregate."
        case .redWiggler:
            return "Red wigglers are a species of earthworm that stays remarkably active in cold water. They are hardier than nightcrawlers and their constant movement attracts attention. Break larger worms into pieces for panfish or use whole for larger species like trout."
        }
    }

    var waterTempRange: String {
        switch self {
        case .bloodworm: return "0-4 C (32-39 F)"
        case .maggot: return "0-6 C (32-43 F)"
        case .breadDough: return "2-8 C (36-46 F)"
        case .mixedLive: return "0-6 C (32-43 F)"
        case .mealworm: return "1-7 C (34-45 F)"
        case .waxWorm: return "0-5 C (32-41 F)"
        case .corn: return "2-8 C (36-46 F)"
        case .artificialLure: return "0-8 C (32-46 F)"
        case .minnow: return "0-6 C (32-43 F)"
        case .doughBall: return "2-8 C (36-46 F)"
        case .cheeseBait: return "1-7 C (34-45 F)"
        case .redWiggler: return "1-6 C (34-43 F)"
        }
    }

    var presentationTechnique: String {
        switch self {
        case .bloodworm: return "Thread 2-3 larvae on a small hook (#14-#18). Use gentle jigging with long pauses. Feed small pinches regularly."
        case .maggot: return "Hook 1-3 maggots through the blunt end. Deadstick or micro-jig. Feed a few loose maggots down the hole every 5 minutes."
        case .breadDough: return "Form pea-sized balls around a #10-#12 hook. Fish on bottom. Squeeze firmly so it holds but releases scent."
        case .mixedLive: return "Layer bloodworms and maggots in a feeding cone. Tip your hook with the best performer. Alternate presentations."
        case .mealworm: return "Hook through the head on a #10-#14 hook. Let it dangle naturally or use slow jigging. Works great on a dropshot rig."
        case .waxWorm: return "Hook once through the thick end on a #12-#16 hook. Fish with minimal movement. Perfect for deadsticking on a second rod."
        case .corn: return "Thread 1-3 kernels on a #10-#12 hook. Fish on bottom with a small sinker. Add a tiny piece of worm for extra scent."
        case .artificialLure: return "Jig aggressively to attract, then slow down. Vary cadence until you find what works. Tip with maggot or wax worm."
        case .minnow: return "Hook through the back or lips on a #4-#8 hook. Use a tip-up for hands-free fishing. Keep minnows lively."
        case .doughBall: return "Mold around a treble or bait-holder hook. Keep dough at body temperature for easier shaping. Fish near bottom structure."
        case .cheeseBait: return "Wrap cheese around hook or use a mesh bag to slow dissolve. Fish near bottom. Strong scent does the work — minimal movement needed."
        case .redWiggler: return "Hook through the collar on a #8-#12 hook. Use half-worm pieces for panfish. Whole worm for trout. Gentle jigging or deadstick."
        }
    }

    var effectivenessRating: Int {
        switch self {
        case .bloodworm: return 5
        case .maggot: return 4
        case .breadDough: return 3
        case .mixedLive: return 4
        case .mealworm: return 4
        case .waxWorm: return 4
        case .corn: return 3
        case .artificialLure: return 3
        case .minnow: return 5
        case .doughBall: return 3
        case .cheeseBait: return 3
        case .redWiggler: return 4
        }
    }

    var bestSeasons: [String] {
        switch self {
        case .bloodworm: return ["Early Ice", "Late Ice"]
        case .maggot: return ["Mid-Winter", "Early Spring"]
        case .breadDough: return ["Late Ice"]
        case .mixedLive: return ["Mid-Winter"]
        case .mealworm: return ["Early Ice", "Late Ice"]
        case .waxWorm: return ["Mid-Winter"]
        case .corn: return ["Late Ice"]
        case .artificialLure: return ["Early Ice", "All Season"]
        case .minnow: return ["Early Ice"]
        case .doughBall: return ["Late Ice"]
        case .cheeseBait: return ["Mid-Winter", "Late Ice"]
        case .redWiggler: return ["Early Ice", "Late Ice"]
        }
    }

    // grams per hour per hole
    func rateFor(_ species: FishSpecies) -> Double {
        species.consumptionRates[self] ?? 5.0
    }
}

// Kept as typealias so old references compile — but the enum above is the real type
typealias BaitType = BaitMaterial
