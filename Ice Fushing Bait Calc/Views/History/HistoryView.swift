import SwiftUI

struct HistoryView: View {
    @StateObject private var profileManager = ProfileManager.shared
    @State private var selectedEntry: HistoryEntry?
    
    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.Colors.background
                    .ignoresSafeArea()
                
                if profileManager.history.isEmpty {
                    VStack(spacing: 16) {
                        HistoryIcon(size: 64, color: AppTheme.Colors.textSecondary)
                        
                        Text("No History Yet")
                            .font(.headline)
                            .foregroundColor(AppTheme.Colors.textPrimary)
                        
                        Text("Your saved calculations will appear here")
                            .font(.subheadline)
                            .foregroundColor(AppTheme.Colors.textSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(profileManager.history) { entry in
                                HistoryCard(entry: entry)
                                    .onTapGesture {
                                        selectedEntry = entry
                                    }
                            }
                        }
                        .padding(AppTheme.Dimensions.padding)
                    }
                }
            }
            .navigationTitle("History")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !profileManager.history.isEmpty {
                        Button("Clear") {
                            profileManager.clearHistory()
                        }
                        .foregroundColor(AppTheme.Colors.secondary)
                    }
                }
            }
            .sheet(item: $selectedEntry) { entry in
                HistoryDetailView(entry: entry)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HistoryCard: View {
    let entry: HistoryEntry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(Int(entry.result.totalBait))g total")
                        .font(.headline)
                        .foregroundColor(AppTheme.Colors.primary)
                    
                    Text(entry.formattedDate)
                        .font(.caption)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }
                
                Spacer()
                
                if let feedback = entry.feedbackRating {
                    FeedbackBadge(rating: feedback)
                }
                
                ArrowRightIcon(size: 20, color: AppTheme.Colors.textSecondary)
            }
            
            HStack(spacing: 16) {
                HStack(spacing: 4) {
                    ClockIcon(size: 16, color: AppTheme.Colors.accent)
                    Text("\(entry.result.hours)h")
                        .font(.caption)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }
                
                HStack(spacing: 4) {
                    HoleIcon(size: 16, color: AppTheme.Colors.success)
                    Text("\(entry.result.holes) holes")
                        .font(.caption)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }
                
                HStack(spacing: 4) {
                    FishIcon(size: 16, color: AppTheme.Colors.primary)
                    Text(entry.result.fishType.rawValue)
                        .font(.caption)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }
            }
            
            if !entry.notes.isEmpty {
                Text(entry.notes)
                    .font(.caption)
                    .foregroundColor(AppTheme.Colors.textSecondary)
                    .lineLimit(2)
            }
        }
        .padding(AppTheme.Dimensions.padding)
        .cardStyle()
    }
}

struct FeedbackBadge: View {
    let rating: FeedbackRating
    
    var color: Color {
        switch rating {
        case .tooMuch:
            return AppTheme.Colors.warning
        case .perfect:
            return AppTheme.Colors.success
        case .notEnough:
            return AppTheme.Colors.secondary
        }
    }
    
    var body: some View {
        Text(rating.rawValue)
            .font(.caption)
            .fontWeight(.medium)
            .foregroundColor(color)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(color.opacity(0.15))
            .cornerRadius(8)
    }
}
