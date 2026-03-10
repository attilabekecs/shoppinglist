import SwiftUI
import SwiftData

struct ItemEditorView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    var list: ShoppingList
    var item: ShoppingItem?

    @State private var name: String = ""
    @State private var quantity: String = ""
    @State private var category: ProductCategory = .other

    var body: some View {

        NavigationStack {

            Form {

                Section("Termék") {

                    TextField("Név", text: $name)

                    TextField("Mennyiség", text: $quantity)
                }

                Section("Kategória") {

                    Picker("Kategória", selection: $category) {

                        ForEach(ProductCategory.allCases, id: \.self) { cat in
                            Text(cat.rawValue)
                                .tag(cat)
                        }
                    }
                }
            }

            .navigationTitle(item == nil ? "Új termék" : "Termék szerkesztése")

            .toolbar {

                ToolbarItem(placement: .topBarLeading) {

                    Button("Mégse") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {

                    Button("Mentés") {
                        save()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }

        .onAppear {

            if let item {

                name = item.name
                quantity = item.quantity
                category = item.category
            }
        }
    }

    private func save() {

        if let item {

            item.name = name
            item.quantity = quantity
            item.category = category

        } else {

            let newItem = ShoppingItem(
                name: name,
                quantity: quantity,
                category: category
            )

            newItem.list = list

            context.insert(newItem)
        }

        dismiss()
    }
}
