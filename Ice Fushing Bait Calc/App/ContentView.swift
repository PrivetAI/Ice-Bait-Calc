import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CalculatorView()
                .tabItem {
                    TabIconCalculator()
                    Text("Calculate")
                }
                .tag(0)
            
            ProfilesView()
                .tabItem {
                    TabIconProfile()
                    Text("Profiles")
                }
                .tag(1)
            
            HistoryView()
                .tabItem {
                    TabIconHistory()
                    Text("History")
                }
                .tag(2)
            
            KnowledgeView()
                .tabItem {
                    TabIconBook()
                    Text("Learn")
                }
                .tag(3)
        }
        .accentColor(AppTheme.Colors.primary)
    }
}
