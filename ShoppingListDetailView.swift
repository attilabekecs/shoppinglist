import SwiftUI
import SwiftData

struct ShoppingListDetailView: View {

    @Environment(\.modelContext) private var context

    var list: ShoppingList

    var body: some View {

        List {

            ForEach(list.items) { item in

                HStack {

                    Button {
                        item.isChecked.toggle()
                    } label: {

                        Image(systemName:
                            item.isChecked
                            ? "checkmark.circle.fill"
                            : "circle"
                        )
                    }

                    Text(item.name)

                    Spacer()

                    Text(item.quantity)
                }
            }
        }
        .navigationTitle(list.title)
        .toolbar {

            Button {

                let item = ShoppingItem(name: "Új termék")
                item.list = list

                context.insert(item)

            } label: {
                Image(systemName: "plus")
            }
        }
    }
}
