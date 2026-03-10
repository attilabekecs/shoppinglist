import SwiftUI
import SwiftData

struct QuickAddView: View {

    @Environment(\.modelContext) private var context
    @Query private var quickItems: [QuickAddItem]

    var list: ShoppingList

    var body: some View {

        ScrollView(.horizontal, showsIndicators: false) {

            HStack {

                ForEach(quickItems) { item in

                    Button {

                        addItem(item)

                    } label: {

                        Text("+ \(item.name)")
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(.blue.opacity(0.15))
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.horizontal)
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
