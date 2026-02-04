import SwiftUI

struct ProfilesView: View {
    @StateObject private var profileManager = ProfileManager.shared
    @State private var showAddProfile = false
    @State private var editingProfile: BaitProfile?
    
    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.Colors.background
                    .ignoresSafeArea()
                
                if profileManager.profiles.isEmpty {
                    VStack(spacing: 16) {
                        ProfileIcon(size: 64, color: AppTheme.Colors.textSecondary)
                        
                        Text("No Profiles Yet")
                            .font(.headline)
                            .foregroundColor(AppTheme.Colors.textPrimary)
                        
                        Text("Profiles let you save your favorite fishing setups. Create a profile once, then quickly load it in the Calculator tab instead of entering settings manually each time.")
                            .font(.subheadline)
                            .foregroundColor(AppTheme.Colors.textSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                        
                        PrimaryButton(
                            title: "Create First Profile",
                            action: { showAddProfile = true },
                            isFullWidth: false
                        )
                        .padding(.top, 8)
                    }
                } else {
                    ScrollView {
                        VStack(spacing: 12) {
                            // Explanation card
                            HStack {
                                Text("Tap a profile in the Calculator tab to quickly load its settings")
                                    .font(.caption)
                                    .foregroundColor(AppTheme.Colors.textSecondary)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(AppTheme.Colors.surface)
                            .cornerRadius(AppTheme.Dimensions.cornerRadius)
                            
                            ForEach(profileManager.profiles) { profile in
                                ProfileCard(
                                    profile: profile,
                                    onEdit: { editingProfile = profile },
                                    onDelete: { profileManager.deleteProfile(profile) }
                                )
                            }
                        }
                        .padding(AppTheme.Dimensions.padding)
                    }
                }
            }
            .navigationTitle("Profiles")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddProfile = true }) {
                        PlusIcon(size: 24, color: AppTheme.Colors.primary)
                    }
                }
            }
            .sheet(isPresented: $showAddProfile) {
                ProfileEditView(profile: nil)
            }
            .sheet(item: $editingProfile) { profile in
                ProfileEditView(profile: profile)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ProfileCard: View {
    let profile: BaitProfile
    let onEdit: () -> Void
    let onDelete: () -> Void
    @State private var showDeleteAlert = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(profile.name)
                        .font(.headline)
                        .foregroundColor(AppTheme.Colors.textPrimary)
                    
                    Text("\(profile.fishType.rawValue) • \(profile.baitType.rawValue)")
                        .font(.subheadline)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }
                
                Spacer()
                
                HStack(spacing: 16) {
                    Button(action: onEdit) {
                        Text("Edit")
                            .font(.subheadline)
                            .foregroundColor(AppTheme.Colors.primary)
                    }
                    
                    Button(action: { showDeleteAlert = true }) {
                        TrashIcon(size: 20, color: AppTheme.Colors.secondary)
                    }
                }
            }
            
            HStack(spacing: 16) {
                HStack(spacing: 4) {
                    ClockIcon(size: 16, color: AppTheme.Colors.accent)
                    Text("\(profile.defaultHours)h")
                        .font(.caption)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }
                
                HStack(spacing: 4) {
                    HoleIcon(size: 16, color: AppTheme.Colors.success)
                    Text("\(profile.defaultHoles) holes")
                        .font(.caption)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }
            }
        }
        .padding(AppTheme.Dimensions.padding)
        .cardStyle()
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text("Delete Profile"),
                message: Text("Are you sure you want to delete '\(profile.name)'?"),
                primaryButton: .destructive(Text("Delete")) { onDelete() },
                secondaryButton: .cancel()
            )
        }
    }
}
