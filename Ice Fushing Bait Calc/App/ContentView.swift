import SwiftUI

// Single-screen dashboard with expandable sections (NO TabView)
struct ContentView: View {
    @StateObject private var state = AppState.shared

    @State private var journalOpen = true
    @State private var recipesOpen = false
    @State private var encyclopediaOpen = false
    @State private var speciesGuideOpen = false
    @State private var calendarOpen = false
    @State private var tipsOpen = false

    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.Palette.parchment.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: AppTheme.Spacing.md) {
                        // Brand header
                        headerBanner

                        // Expandable sections
                        sectionWrapper {
                            JournalSectionView(state: state, expanded: $journalOpen)
                        }

                        sectionWrapper {
                            RecipeSectionView(state: state, expanded: $recipesOpen)
                        }

                        sectionWrapper {
                            BaitEncyclopediaSectionView(expanded: $encyclopediaOpen)
                        }

                        sectionWrapper {
                            SpeciesGuideSectionView(expanded: $speciesGuideOpen)
                        }

                        sectionWrapper {
                            SeasonalCalendarView(expanded: $calendarOpen)
                        }

                        sectionWrapper {
                            KnowledgeSectionView(expanded: $tipsOpen)
                        }

                        Spacer(minLength: 40)
                    }
                    .padding(.horizontal, AppTheme.Spacing.md)
                    .padding(.top, AppTheme.Spacing.sm)
                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    // MARK: - Header

    private var headerBanner: some View {
        VStack(spacing: 6) {
            // Rustic logo shape
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            colors: [AppTheme.Palette.darkWood, AppTheme.Palette.bark],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 90)
                    .shadow(color: AppTheme.Palette.shadow.opacity(0.25), radius: 8, x: 0, y: 4)

                HStack(spacing: 14) {
                    IcoFish(sz: 40, tint: AppTheme.Palette.cream)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Ice Fushing Bait Calc")
                            .font(.system(size: 22, weight: .heavy, design: .rounded))
                            .foregroundColor(AppTheme.Palette.cream)
                        Text("Your bait journal and recipe book")
                            .font(.system(size: 13, weight: .medium, design: .rounded))
                            .foregroundColor(AppTheme.Palette.wheat)
                    }
                    Spacer()
                    IcoSnowflake(sz: 30, tint: AppTheme.Palette.wheat.opacity(0.5))
                }
                .padding(.horizontal, 20)
            }
        }
    }

    // MARK: - Section container

    private func sectionWrapper<C: View>(@ViewBuilder _ content: () -> C) -> some View {
        VStack {
            content()
        }
        .padding(AppTheme.Spacing.md)
        .background(
            RoundedRectangle(cornerRadius: AppTheme.Radius.section)
                .fill(AppTheme.Palette.cream)
                .shadow(color: AppTheme.Palette.shadow.opacity(0.08), radius: 6, x: 0, y: 3)
        )
        .overlay(
            RoundedRectangle(cornerRadius: AppTheme.Radius.section)
                .stroke(AppTheme.Palette.bark.opacity(0.12), lineWidth: 1)
        )
    }
}
