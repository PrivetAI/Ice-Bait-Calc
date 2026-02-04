import SwiftUI

struct ArticleView: View {
    let article: KnowledgeArticle
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.Colors.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(parseContent(article.content), id: \.self) { section in
                            if section.hasPrefix("###") {
                                Text(section.replacingOccurrences(of: "### ", with: ""))
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(AppTheme.Colors.primary)
                                    .padding(.top, 8)
                            } else if section.uppercased() == section && section.count > 3 {
                                Text(section)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(AppTheme.Colors.textPrimary)
                                    .padding(.top, 12)
                            } else if section.hasPrefix("- ") {
                                HStack(alignment: .top, spacing: 8) {
                                    Circle()
                                        .fill(AppTheme.Colors.primary)
                                        .frame(width: 6, height: 6)
                                        .padding(.top, 6)
                                    
                                    Text(section.replacingOccurrences(of: "- ", with: ""))
                                        .font(.body)
                                        .foregroundColor(AppTheme.Colors.textPrimary)
                                }
                            } else if !section.isEmpty {
                                Text(section)
                                    .font(.body)
                                    .foregroundColor(AppTheme.Colors.textPrimary)
                                    .lineSpacing(4)
                            }
                        }
                    }
                    .padding(AppTheme.Dimensions.padding)
                }
            }
            .navigationTitle(article.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    
    private func parseContent(_ content: String) -> [String] {
        content.components(separatedBy: "\n")
    }
}
