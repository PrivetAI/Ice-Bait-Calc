import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CalculatorView()
                .tabItem {
                    VStack {
                        CalculatorIcon(size: 24, color: selectedTab == 0 ? AppTheme.Colors.primary : AppTheme.Colors.textSecondary)
                        Text("Calculate")
                    }
                }
                .tag(0)
            
            ProfilesView()
                .tabItem {
                    VStack {
                        ProfileIcon(size: 24, color: selectedTab == 1 ? AppTheme.Colors.primary : AppTheme.Colors.textSecondary)
                        Text("Profiles")
                    }
                }
                .tag(1)
            
            HistoryView()
                .tabItem {
                    VStack {
                        HistoryIcon(size: 24, color: selectedTab == 2 ? AppTheme.Colors.primary : AppTheme.Colors.textSecondary)
                        Text("History")
                    }
                }
                .tag(2)
            
            KnowledgeView()
                .tabItem {
                    VStack {
                        BookIcon(size: 24, color: selectedTab == 3 ? AppTheme.Colors.primary : AppTheme.Colors.textSecondary)
                        Text("Learn")
                    }
                }
                .tag(3)
        }
        .accentColor(AppTheme.Colors.primary)
    }
}
