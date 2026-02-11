import SwiftUI

@main
struct IceFushingBaitCalcApp: App {
    init() {
        setupAppearance()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
    }

    private func setupAppearance() {
        let bark = UIColor(red: 101/255, green: 67/255, blue: 33/255, alpha: 1)
        let cream = UIColor(red: 255/255, green: 243/255, blue: 224/255, alpha: 1)

        let nav = UINavigationBarAppearance()
        nav.configureWithOpaqueBackground()
        nav.backgroundColor = cream
        nav.titleTextAttributes = [.foregroundColor: bark]
        nav.largeTitleTextAttributes = [.foregroundColor: bark]

        UINavigationBar.appearance().standardAppearance = nav
        UINavigationBar.appearance().scrollEdgeAppearance = nav
        UINavigationBar.appearance().compactAppearance = nav
        UINavigationBar.appearance().tintColor = bark
    }
}
