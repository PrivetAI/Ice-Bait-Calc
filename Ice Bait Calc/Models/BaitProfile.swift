import Foundation

struct BaitProfile: Codable, Identifiable {
    let id: UUID
    var name: String
    var fishType: FishType
    var baitType: BaitType
    var defaultHours: Int
    var defaultHoles: Int
    var createdAt: Date
    var updatedAt: Date
    
    init(
        id: UUID = UUID(),
        name: String,
        fishType: FishType,
        baitType: BaitType,
        defaultHours: Int = 4,
        defaultHoles: Int = 3,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.fishType = fishType
        self.baitType = baitType
        self.defaultHours = defaultHours
        self.defaultHoles = defaultHoles
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    mutating func update(
        name: String? = nil,
        fishType: FishType? = nil,
        baitType: BaitType? = nil,
        defaultHours: Int? = nil,
        defaultHoles: Int? = nil
    ) {
        if let name = name { self.name = name }
        if let fishType = fishType { self.fishType = fishType }
        if let baitType = baitType { self.baitType = baitType }
        if let defaultHours = defaultHours { self.defaultHours = defaultHours }
        if let defaultHoles = defaultHoles { self.defaultHoles = defaultHoles }
        self.updatedAt = Date()
    }
}
