import Foundation

class CalculationService {
    static let shared = CalculationService()
    
    private init() {}
    
    func calculate(
        fishType: FishType,
        baitType: BaitType,
        hours: Int,
        holes: Int
    ) -> CalculationResult {
        let baseRate = fishType.baseRates[baitType] ?? 5.0
        
        let startFeed = baseRate * Double(holes) * 1.5
        let hourlyFeed = baseRate * Double(holes)
        let totalBait = startFeed + (hourlyFeed * Double(max(hours - 1, 0)))
        
        return CalculationResult(
            fishType: fishType,
            baitType: baitType,
            hours: hours,
            holes: holes,
            totalBait: totalBait,
            startFeed: startFeed,
            hourlyFeed: hourlyFeed
        )
    }
}
