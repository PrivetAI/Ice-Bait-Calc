import SwiftUI

struct ResultView: View {
    let result: CalculationResult?
    @StateObject private var profileManager = ProfileManager.shared
    @State private var showSaveConfirmation = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            AppTheme.Colors.background
                .ignoresSafeArea()
            
            if let result = result {
                ScrollView {
                    VStack(spacing: 20) {
                        // Main result
                        LargeResultCard(
                            value: String(format: "%.0f", result.totalBait),
                            unit: "grams",
                            subtitle: result.visualEquivalent
                        )
                        
                        // Breakdown
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Breakdown")
                                .font(.headline)
                                .foregroundColor(AppTheme.Colors.textPrimary)
                            
                            HStack(spacing: 12) {
                                ResultCard(
                                    title: "Start Feed",
                                    value: String(format: "%.0f g", result.startFeed),
                                    subtitle: "Per hole initially",
                                    icon: nil,
                                    accentColor: AppTheme.Colors.secondary
                                )
                                
                                ResultCard(
                                    title: "Hourly Feed",
                                    value: String(format: "%.0f g", result.hourlyFeed),
                                    subtitle: "All holes per hour",
                                    icon: nil,
                                    accentColor: AppTheme.Colors.success
                                )
                            }
                        }
                        
                        // Parameters summary
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Parameters")
                                .font(.headline)
                                .foregroundColor(AppTheme.Colors.textPrimary)
                            
                            VStack(spacing: 8) {
                                ParameterRow(label: "Duration", value: "\(result.hours) hours")
                                ParameterRow(label: "Holes", value: "\(result.holes)")
                                ParameterRow(label: "Fish", value: result.fishType.rawValue)
                                ParameterRow(label: "Bait", value: result.baitType.rawValue)
                            }
                            .padding(AppTheme.Dimensions.padding)
                            .cardStyle()
                        }
                        
                        // Save button
                        PrimaryButton(
                            title: "Save Calculation",
                            action: saveCalculation,
                            style: .accent
                        )
                    }
                    .padding(AppTheme.Dimensions.padding)
                }
            }
        }
        .navigationTitle("Result")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showSaveConfirmation) {
            Alert(
                title: Text("Saved"),
                message: Text("Calculation saved to history"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private func saveCalculation() {
        guard let result = result else { return }
        profileManager.addToHistory(result)
        showSaveConfirmation = true
    }
}

struct ParameterRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(AppTheme.Colors.textSecondary)
            Spacer()
            Text(value)
                .fontWeight(.medium)
                .foregroundColor(AppTheme.Colors.textPrimary)
        }
    }
}
