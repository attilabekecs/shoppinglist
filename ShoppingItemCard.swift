import SwiftUI

struct ShoppingItemCard: View {

    var item: ShoppingItem
    var onToggle: () -> Void
    var onTap: () -> Void

    var body: some View {

        Button {

            onTap()

        } label: {

            HStack(spacing: 16) {

                if let data = item.imageData,
                   let image = UIImage(data: data) {

                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 52, height: 52)
                        .clipShape(RoundedRectangle(cornerRadius: 12))

                } else {

                    Image(systemName: "cart")
                        .font(.system(size: 24))
                        .frame(width: 52, height: 52)
                        .background(.quaternary)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }

                VStack(alignment: .leading, spacing: 4) {

                    Text(item.name)
                        .font(.headline)
                        .strikethrough(item.isChecked)

                    if !item.quantity.isEmpty {

                        Text(item.quantity)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }

                Spacer()

                Button {

                    onToggle()

                } label: {

                    Image(systemName:
                        item.isChecked
                        ? "checkmark.circle.fill"
                        : "circle"
                    )
                    .font(.title3)
                }
                .buttonStyle(.plain)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(.ultraThinMaterial)
            )
        }
        .buttonStyle(.plain)
    }
}
