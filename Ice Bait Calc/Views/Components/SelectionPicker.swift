import SwiftUI

struct SelectionPicker<T: Hashable & Identifiable>: View where T: RawRepresentable, T.RawValue == String {
    let title: String
    let icon: AnyView
    let options: [T]
    @Binding var selection: T
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                icon
                Text(title)
                    .font(.headline)
                    .foregroundColor(AppTheme.Colors.textPrimary)
            }
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 10) {
                ForEach(options) { option in
                    SelectionButton(
                        title: option.rawValue,
                        isSelected: selection.id == option.id,
                        action: { selection = option }
                    )
                }
            }
        }
        .padding(AppTheme.Dimensions.padding)
        .cardStyle()
    }
}

struct SelectionButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundColor(isSelected ? .white : AppTheme.Colors.textPrimary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isSelected ? AppTheme.Colors.primary : AppTheme.Colors.surface)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isSelected ? AppTheme.Colors.primary : Color.clear, lineWidth: 2)
                )
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
