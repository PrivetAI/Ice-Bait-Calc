import Foundation

struct HistoryEntry: Codable, Identifiable {
    let id: UUID
    let result: CalculationResult
    var notes: String
    var feedbackRating: FeedbackRating?
    let createdAt: Date
    var updatedAt: Date
    
    init(
        id: UUID = UUID(),
        result: CalculationResult,
        notes: String = "",
        feedbackRating: FeedbackRating? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.result = result
        self.notes = notes
        self.feedbackRating = feedbackRating
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    mutating func addNote(_ note: String) {
        self.notes = note
        self.updatedAt = Date()
    }
    
    mutating func setFeedback(_ rating: FeedbackRating) {
        self.feedbackRating = rating
        self.updatedAt = Date()
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: createdAt)
    }
}

enum FeedbackRating: String, Codable, CaseIterable {
    case tooMuch = "Too Much"
    case perfect = "Perfect"
    case notEnough = "Not Enough"
    
    var description: String {
        switch self {
        case .tooMuch:
            return "Had leftover bait"
        case .perfect:
            return "Just right amount"
        case .notEnough:
            return "Ran out of bait"
        }
    }
}
