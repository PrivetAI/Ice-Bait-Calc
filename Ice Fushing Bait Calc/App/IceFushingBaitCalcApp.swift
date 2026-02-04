import SwiftUI

@main
struct IceFushingBaitCalcApp: App {
    init() {
        configureAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
    }
    
    private func configureAppearance() {
        // Configure navigation bar
        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithOpaqueBackground()
        navAppearance.backgroundColor = UIColor(AppTheme.Colors.background)
        navAppearance.titleTextAttributes = [.foregroundColor: UIColor(AppTheme.Colors.textPrimary)]
        navAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(AppTheme.Colors.textPrimary)]
        
        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
        UINavigationBar.appearance().compactAppearance = navAppearance
        
        // Configure tab bar
        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithOpaqueBackground()
        tabAppearance.backgroundColor = UIColor(AppTheme.Colors.cardBackground)
        
        UITabBar.appearance().standardAppearance = tabAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabAppearance
        }
    }
}
