import SwiftUI

struct CalculatorView: View {
    @StateObject private var profileManager = ProfileManager.shared
    @State private var hours: Double = 4
    @State private var holes: Double = 3
    @State private var selectedFish: FishType = .perch
    @State private var selectedBait: BaitType = .bloodworm
    @State private var showResult = false
    @State private var calculationResult: CalculationResult?
    
    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.Colors.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        // Hours slider
                        CustomSlider(
                            title: "Fishing Duration",
                            value: $hours,
                            range: 1...12,
                            step: 1,
                            icon: AnyView(ClockIcon(size: 24, color: AppTheme.Colors.accent)),
                            unit: "hours"
                        )
                        
                        // Holes slider
                        CustomSlider(
                            title: "Number of Holes",
                            value: $holes,
                            range: 1...10,
                            step: 1,
                            icon: AnyView(HoleIcon(size: 24, color: AppTheme.Colors.success)),
                            unit: "holes"
                        )
                        
                        // Fish type picker
                        SelectionPicker(
                            title: "Target Fish",
                            icon: AnyView(FishIcon(size: 24, color: AppTheme.Colors.primary)),
                            options: FishType.allCases,
                            selection: $selectedFish
                        )
                        
                        // Bait type picker
                        SelectionPicker(
                            title: "Bait Type",
                            icon: AnyView(BaitIcon(size: 24, color: AppTheme.Colors.secondary)),
                            options: BaitType.allCases,
                            selection: $selectedBait
                        )
                        
                        // Calculate button
                        PrimaryButton(
                            title: "Calculate",
                            icon: AnyView(CalculatorIcon(size: 24, color: .white)),
                            action: calculateBait
                        )
                        .padding(.top, 8)
                    }
                    .padding(AppTheme.Dimensions.padding)
                }
                
                // Navigation to result
                NavigationLink(
                    destination: ResultView(result: calculationResult),
                    isActive: $showResult
                ) {
                    EmptyView()
                }
            }
            .navigationTitle("Ice Bait Calc")
            .navigationBarTitleDisplayMode(.large)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func calculateBait() {
        let result = CalculationService.shared.calculate(
            fishType: selectedFish,
            baitType: selectedBait,
            hours: Int(hours),
            holes: Int(holes)
        )
        calculationResult = result
        showResult = true
    }
    
    func loadProfile(_ profile: BaitProfile) {
        hours = Double(profile.defaultHours)
        holes = Double(profile.defaultHoles)
        selectedFish = profile.fishType
        selectedBait = profile.baitType
    }
}
