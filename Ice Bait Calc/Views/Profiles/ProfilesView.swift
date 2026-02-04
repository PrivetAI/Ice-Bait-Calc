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
                    EmptyStateView(
                        icon: AnyView(ProfileIcon(size: 64, color: AppTheme.Colors.textSecondary)),
                        title: "No Profiles Yet",
                        message: "Create a profile to quickly load your favorite fishing settings"
                    )
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
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
                Label("\(profile.defaultHours)h", icon: AnyView(ClockIcon(size: 16, color: AppTheme.Colors.accent)))
                Label("\(profile.defaultHoles) holes", icon: AnyView(HoleIcon(size: 16, color: AppTheme.Colors.success)))
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

struct Label: View {
    let text: String
    let icon: AnyView
    
    init(_ text: String, icon: AnyView) {
        self.text = text
        self.icon = icon
    }
    
    var body: some View {
        HStack(spacing: 4) {
            icon
            Text(text)
                .font(.caption)
                .foregroundColor(AppTheme.Colors.textSecondary)
        }
    }
}

struct EmptyStateView: View {
    let icon: AnyView
    let title: String
    let message: String
    
    var body: some View {
        VStack(spacing: 16) {
            icon
            
            Text(title)
                .font(.headline)
                .foregroundColor(AppTheme.Colors.textPrimary)
            
            Text(message)
                .font(.subheadline)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
    }
}
