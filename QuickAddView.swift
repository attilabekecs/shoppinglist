import SwiftUI
import SwiftData

struct QuickAddView: View {

    @Environment(\.modelContext) private var context
    @Query private var quickItems: [QuickAddItem]

    var list: ShoppingList

    var body: some View {

        ScrollView(.horizontal, showsIndicators: false) {

            HStack(spacing: 10) {

                ForEach(quickItems) { item in

                    Button {

                        addItem(item)

                    } label: {

                        HStack(spacing: 6) {

                            Image(systemName: "plus")

                            Text(item.name)
                        }
                        .font(.subheadline)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .fill(.ultraThinMaterial)
                        )
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 6)
        }
    }

    private func addItem(_ quickItem: QuickAddItem) {

        let item = ShoppingItem(
            name: quickItem.name,
            quantity: "",
            category: quickItem.category
        )

        item.list = list

        context.insert(item)
    }
}
