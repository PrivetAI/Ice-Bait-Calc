import SwiftUI

struct CalculatorView: View {
    @StateObject private var profileManager = ProfileManager.shared
    @State private var hours: Double = 4
    @State private var holes: Double = 3
    @State private var selectedFish: FishType = .perch
    @State private var selectedBait: BaitType = .bloodworm
    @State private var showResult = false
    @State private var calculationResult: CalculationResult?
    @State private var showProfilePicker = false
    
    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.Colors.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        // Load from profile button
                        if !profileManager.profiles.isEmpty {
                            Button(action: { showProfilePicker = true }) {
                                HStack {
                                    ProfileIcon(size: 20, color: AppTheme.Colors.primary)
                                    Text("Load from Profile")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                    Spacer()
                                    ArrowRightIcon(size: 16, color: AppTheme.Colors.textSecondary)
                                }
                                .padding()
                                .background(AppTheme.Colors.cardBackground)
                                .cornerRadius(AppTheme.Dimensions.cornerRadius)
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                        
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
            .navigationTitle("Ice Fushing Bait Calc")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showProfilePicker) {
                ProfilePickerSheet(
                    profiles: profileManager.profiles,
                    onSelect: { profile in
                        loadProfile(profile)
                        showProfilePicker = false
                    }
                )
            }
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
    
    private func loadProfile(_ profile: BaitProfile) {
        hours = Double(profile.defaultHours)
        holes = Double(profile.defaultHoles)
        selectedFish = profile.fishType
        selectedBait = profile.baitType
    }
}

// MARK: - Profile Picker Sheet
struct ProfilePickerSheet: View {
    let profiles: [BaitProfile]
    let onSelect: (BaitProfile) -> Void
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.Colors.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 12) {
                        Text("Select a profile to load its settings into the calculator")
                            .font(.subheadline)
                            .foregroundColor(AppTheme.Colors.textSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 8)
                        
                        ForEach(profiles) { profile in
                            Button(action: { onSelect(profile) }) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(profile.name)
                                            .font(.headline)
                                            .foregroundColor(AppTheme.Colors.textPrimary)
                                        
                                        Text("\(profile.fishType.rawValue) • \(profile.baitType.rawValue)")
                                            .font(.caption)
                                            .foregroundColor(AppTheme.Colors.textSecondary)
                                        
                                        Text("\(profile.defaultHours)h • \(profile.defaultHoles) holes")
                                            .font(.caption)
                                            .foregroundColor(AppTheme.Colors.textSecondary)
                                    }
                                    
                                    Spacer()
                                    
                                    ArrowRightIcon(size: 20, color: AppTheme.Colors.primary)
                                }
                                .padding()
                                .cardStyle()
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                    .padding(AppTheme.Dimensions.padding)
                }
            }
            .navigationTitle("Load Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}
