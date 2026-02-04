import SwiftUI

struct KnowledgeView: View {
    @State private var selectedArticle: KnowledgeArticle?
    
    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.Colors.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        // Bait types section
                        SectionHeader(title: "Bait Types")
                        
                        ForEach(BaitType.allCases) { bait in
                            KnowledgeCard(
                                title: bait.rawValue,
                                subtitle: bait.shortDescription,
                                onTap: {
                                    selectedArticle = KnowledgeArticle(
                                        title: bait.rawValue,
                                        content: baitArticle(for: bait)
                                    )
                                }
                            )
                        }
                        
                        // Fish species section
                        SectionHeader(title: "Fish Species")
                        
                        ForEach(FishType.allCases) { fish in
                            KnowledgeCard(
                                title: fish.rawValue,
                                subtitle: fish.description,
                                onTap: {
                                    selectedArticle = KnowledgeArticle(
                                        title: fish.rawValue,
                                        content: fishArticle(for: fish)
                                    )
                                }
                            )
                        }
                        
                        // Common mistakes section
                        SectionHeader(title: "Common Mistakes")
                        
                        KnowledgeCard(
                            title: "Overfeeding",
                            subtitle: "Learn why less is often more",
                            onTap: {
                                selectedArticle = KnowledgeArticle(
                                    title: "Overfeeding Mistakes",
                                    content: overfeedingArticle
                                )
                            }
                        )
                        
                        KnowledgeCard(
                            title: "Wrong Timing",
                            subtitle: "When to feed and when to wait",
                            onTap: {
                                selectedArticle = KnowledgeArticle(
                                    title: "Timing Mistakes",
                                    content: timingArticle
                                )
                            }
                        )
                        
                        KnowledgeCard(
                            title: "Bait Storage",
                            subtitle: "Keep your bait fresh and effective",
                            onTap: {
                                selectedArticle = KnowledgeArticle(
                                    title: "Storage Mistakes",
                                    content: storageArticle
                                )
                            }
                        )
                    }
                    .padding(AppTheme.Dimensions.padding)
                }
            }
            .navigationTitle("Knowledge Base")
            .navigationBarTitleDisplayMode(.large)
            .sheet(item: $selectedArticle) { article in
                ArticleView(article: article)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func baitArticle(for bait: BaitType) -> String {
        """
        \(bait.shortDescription)
        
        BEST FOR
        \(bait.bestFor.map { $0.rawValue }.joined(separator: ", "))
        
        STORAGE
        \(bait.storageInfo)
        
        USAGE TIPS
        \(bait.usageTips)
        """
    }
    
    private func fishArticle(for fish: FishType) -> String {
        let bestBait = fish.baseRates.max(by: { $0.value < $1.value })?.key ?? .bloodworm
        
        return """
        \(fish.description)
        
        RECOMMENDED BAIT
        Best: \(bestBait.rawValue)
        
        FEEDING BEHAVIOR
        This species responds best to consistent, measured feeding. Start with a generous initial portion and maintain steady hourly additions.
        
        BASE CONSUMPTION
        Bloodworm: \(Int(fish.baseRates[.bloodworm] ?? 0))g/hour/hole
        Maggot: \(Int(fish.baseRates[.maggot] ?? 0))g/hour/hole
        Plant: \(Int(fish.baseRates[.plant] ?? 0))g/hour/hole
        Combined: \(Int(fish.baseRates[.combined] ?? 0))g/hour/hole
        """
    }
    
    private var overfeedingArticle: String {
        """
        One of the most common mistakes in ice fishing is overfeeding. When fish have too much food available, they become less likely to bite your hook.
        
        SIGNS OF OVERFEEDING
        - Fish are visible but not biting
        - Leftover bait visible in the hole
        - Decreased activity after feeding
        
        HOW TO AVOID
        - Start with calculated amounts
        - Observe fish behavior before adding more
        - Use smaller, more frequent portions
        - Adjust based on fish response
        
        RECOVERY
        If you've overfed, wait 30-60 minutes before adding any more bait. Consider moving to a new hole if available.
        """
    }
    
    private var timingArticle: String {
        """
        Proper timing can make the difference between a successful trip and going home empty-handed.
        
        BEST TIMES TO FEED
        - Early morning (first hour)
        - After a period of inactivity
        - When you notice decreased biting
        
        WHEN NOT TO FEED
        - During active biting periods
        - Immediately after feeding
        - In very cold conditions (feed less)
        
        FEEDING RHYTHM
        Establish a consistent feeding schedule. Fish learn patterns quickly and will anticipate regular feeding times.
        
        WEATHER FACTORS
        - Falling pressure: Feed more actively
        - Rising pressure: Reduce feeding
        - Stable conditions: Maintain rhythm
        """
    }
    
    private var storageArticle: String {
        """
        Proper bait storage is essential for maintaining effectiveness.
        
        GENERAL RULES
        - Keep bait cool but not frozen
        - Maintain proper moisture levels
        - Use breathable containers
        - Avoid direct sunlight
        
        ON THE ICE
        - Store bait inside your jacket
        - Use insulated containers
        - Keep away from fishing holes
        - Protect from wind
        
        SIGNS OF SPOILED BAIT
        - Unusual odor
        - Discoloration
        - Reduced movement (live bait)
        - Mushy texture
        
        Always bring more bait than calculated to account for losses due to improper storage conditions.
        """
    }
}

struct SectionHeader: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(AppTheme.Colors.textPrimary)
            Spacer()
        }
        .padding(.top, 8)
    }
}

struct KnowledgeCard: View {
    let title: String
    let subtitle: String
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(AppTheme.Colors.textPrimary)
                    
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                        .lineLimit(2)
                }
                
                Spacer()
                
                ArrowRightIcon(size: 20, color: AppTheme.Colors.textSecondary)
            }
            .padding(AppTheme.Dimensions.padding)
            .cardStyle()
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

struct KnowledgeArticle: Identifiable {
    let id = UUID()
    let title: String
    let content: String
}
