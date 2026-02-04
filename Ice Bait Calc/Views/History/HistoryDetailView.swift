import SwiftUI

struct HistoryDetailView: View {
    @State var entry: HistoryEntry
    @StateObject private var profileManager = ProfileManager.shared
    @Environment(\.presentationMode) var presentationMode
    @State private var notes: String = ""
    @State private var selectedFeedback: FeedbackRating?
    
    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.Colors.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Result summary
                        LargeResultCard(
                            value: String(format: "%.0f", entry.result.totalBait),
                            unit: "grams",
                            subtitle: entry.result.visualEquivalent
                        )
                        
                        // Parameters
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Parameters")
                                .font(.headline)
                                .foregroundColor(AppTheme.Colors.textPrimary)
                            
                            VStack(spacing: 8) {
                                ParameterRow(label: "Date", value: entry.formattedDate)
                                ParameterRow(label: "Duration", value: "\(entry.result.hours) hours")
                                ParameterRow(label: "Holes", value: "\(entry.result.holes)")
                                ParameterRow(label: "Fish", value: entry.result.fishType.rawValue)
                                ParameterRow(label: "Bait", value: entry.result.baitType.rawValue)
                            }
                            .padding(AppTheme.Dimensions.padding)
                            .cardStyle()
                        }
                        
                        // Feedback section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("How was the bait amount?")
                                .font(.headline)
                                .foregroundColor(AppTheme.Colors.textPrimary)
                            
                            HStack(spacing: 12) {
                                ForEach(FeedbackRating.allCases, id: \.self) { rating in
                                    FeedbackButton(
                                        rating: rating,
                                        isSelected: selectedFeedback == rating,
                                        action: { selectedFeedback = rating }
                                    )
                                }
                            }
                        }
                        
                        // Notes section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Notes")
                                .font(.headline)
                                .foregroundColor(AppTheme.Colors.textPrimary)
                            
                            TextEditor(text: $notes)
                                .frame(minHeight: 100)
                                .padding(8)
                                .background(AppTheme.Colors.cardBackground)
                                .cornerRadius(AppTheme.Dimensions.cornerRadius)
                                .overlay(
                                    RoundedRectangle(cornerRadius: AppTheme.Dimensions.cornerRadius)
                                        .stroke(AppTheme.Colors.surface, lineWidth: 1)
                                )
                        }
                        
                        // Save button
                        PrimaryButton(
                            title: "Save Notes",
                            icon: AnyView(SaveIcon(size: 24, color: .white)),
                            action: saveNotes
                        )
                    }
                    .padding(AppTheme.Dimensions.padding)
                }
            }
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .onAppear {
                notes = entry.notes
                selectedFeedback = entry.feedbackRating
            }
        }
    }
    
    private func saveNotes() {
        entry.notes = notes
        if let feedback = selectedFeedback {
            entry.feedbackRating = feedback
        }
        entry.updatedAt = Date()
        profileManager.updateHistoryEntry(entry)
        presentationMode.wrappedValue.dismiss()
    }
}

struct FeedbackButton: View {
    let rating: FeedbackRating
    let isSelected: Bool
    let action: () -> Void
    
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
        Button(action: action) {
            VStack(spacing: 4) {
                Text(rating.rawValue)
                    .font(.subheadline)
                    .fontWeight(isSelected ? .semibold : .regular)
            }
            .foregroundColor(isSelected ? .white : color)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? color : color.opacity(0.15))
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
