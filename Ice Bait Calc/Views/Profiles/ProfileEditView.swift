import SwiftUI

struct ProfileEditView: View {
    let profile: BaitProfile?
    @StateObject private var profileManager = ProfileManager.shared
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var hours: Double = 4
    @State private var holes: Double = 3
    @State private var selectedFish: FishType = .perch
    @State private var selectedBait: BaitType = .bloodworm
    
    var isEditing: Bool { profile != nil }
    
    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.Colors.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        // Profile name
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Profile Name")
                                .font(.headline)
                                .foregroundColor(AppTheme.Colors.textPrimary)
                            
                            TextField("e.g. My Perch Setup", text: $name)
                                .padding()
                                .background(AppTheme.Colors.cardBackground)
                                .cornerRadius(AppTheme.Dimensions.cornerRadius)
                                .overlay(
                                    RoundedRectangle(cornerRadius: AppTheme.Dimensions.cornerRadius)
                                        .stroke(AppTheme.Colors.surface, lineWidth: 1)
                                )
                        }
                        .padding(AppTheme.Dimensions.padding)
                        .cardStyle()
                        
                        // Hours slider
                        CustomSlider(
                            title: "Default Duration",
                            value: $hours,
                            range: 1...12,
                            step: 1,
                            icon: AnyView(ClockIcon(size: 24, color: AppTheme.Colors.accent)),
                            unit: "hours"
                        )
                        
                        // Holes slider
                        CustomSlider(
                            title: "Default Holes",
                            value: $holes,
                            range: 1...10,
                            step: 1,
                            icon: AnyView(HoleIcon(size: 24, color: AppTheme.Colors.success)),
                            unit: "holes"
                        )
                        
                        // Fish type picker
                        SelectionPicker(
                            title: "Fish Type",
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
                        
                        // Save button
                        PrimaryButton(
                            title: isEditing ? "Update Profile" : "Create Profile",
                            action: saveProfile
                        )
                        .padding(.top, 8)
                        .disabled(name.isEmpty)
                        .opacity(name.isEmpty ? 0.6 : 1)
                    }
                    .padding(AppTheme.Dimensions.padding)
                }
            }
            .navigationTitle(isEditing ? "Edit Profile" : "New Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .onAppear {
                if let profile = profile {
                    name = profile.name
                    hours = Double(profile.defaultHours)
                    holes = Double(profile.defaultHoles)
                    selectedFish = profile.fishType
                    selectedBait = profile.baitType
                }
            }
        }
    }
    
    private func saveProfile() {
        if let existingProfile = profile {
            var updated = existingProfile
            updated.update(
                name: name,
                fishType: selectedFish,
                baitType: selectedBait,
                defaultHours: Int(hours),
                defaultHoles: Int(holes)
            )
            profileManager.updateProfile(updated)
        } else {
            let newProfile = BaitProfile(
                name: name,
                fishType: selectedFish,
                baitType: selectedBait,
                defaultHours: Int(hours),
                defaultHoles: Int(holes)
            )
            profileManager.addProfile(newProfile)
        }
        presentationMode.wrappedValue.dismiss()
    }
}
