import SwiftUI
import SwiftData

struct PantryView: View {

    @Environment(\.modelContext) private var context
    @Query private var pantryItems: [PantryItem]

    @State private var newItemName = ""

    var body: some View {

        NavigationStack {

            List {

                ForEach(pantryItems) { item in

                    HStack {

                        Text(item.name)

                        Spacer()

                        Text(item.quantity)
                            .foregroundStyle(.secondary)
                    }
                }
                .onDelete(perform: deleteItem)

                Section {

                    TextField("Új alapanyag", text: $newItemName)

                    Button("Hozzáadás") {

                        addItem()
                    }
                    .disabled(newItemName.isEmpty)
                }
            }
            .navigationTitle("Otthoni készlet")
        }
    }

    private func addItem() {

        let item = PantryItem(
            name: newItemName,
            quantity: ""
        )

        context.insert(item)

        newItemName = ""
    }

    private func deleteItem(at offsets: IndexSet) {

        for index in offsets {

            context.delete(pantryItems[index])
        }
    }
}
