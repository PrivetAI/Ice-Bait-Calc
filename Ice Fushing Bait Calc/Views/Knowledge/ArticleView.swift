import SwiftUI

// Article detail sheet
struct ArticleSheet: View {
    let article: TipArticle
    @Environment(\.presentationMode) var dismiss

    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.Palette.parchment.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        ForEach(Array(article.sections.enumerated()), id: \.offset) { _, section in
                            VStack(alignment: .leading, spacing: 6) {
                                Text(section.0)
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundColor(AppTheme.Palette.warmOrange)

                                Text(section.1)
                                    .font(.system(size: 15, design: .rounded))
                                    .foregroundColor(AppTheme.Palette.charcoal)
                                    .lineSpacing(4)
                            }
                        }
                    }
                    .padding(AppTheme.Spacing.md)
                }
            }
            .navigationTitle(article.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") { dismiss.wrappedValue.dismiss() }
                        .foregroundColor(AppTheme.Palette.bark)
                }
            }
        }
    }
}
