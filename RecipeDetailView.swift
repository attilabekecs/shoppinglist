import SwiftUI
import SwiftData

enum RecipeAddResult: Identifiable {
    case added
    case nothingToAdd

    var id: Int {
        hashValue
    }
}

struct RecipeDetailView: View {

    @Environment(\.modelContext) private var context

    var recipe: Recipe

    @Query private var lists: [ShoppingList]
    @Query private var pantryItems: [PantryItem]

    @State private var result: RecipeAddResult?
    @State private var selectedList: ShoppingList?

    var body: some View {

        List {

            Section("Hozzávalók") {

                ForEach(recipe.ingredients) { ingredient in

                    HStack {

                        Text(ingredient.name)

                        Spacer()

                        Text(ingredient.quantity)
                            .foregroundStyle(.secondary)
                    }
                }
            }

            Section("Hozzáadás listához") {

                Picker("Lista", selection: $selectedList) {

                    ForEach(lists) { list in
                        Text(list.title)
                            .tag(Optional(list))
                    }
                }

                Button {

                    addIngredientsToList()

                } label: {

                    Label(
                        "Hozzáadás bevásárlólistához",
                        systemImage: "cart.badge.plus"
                    )
                }
                .disabled(selectedList == nil)
            }
        }
        .navigationTitle(recipe.name)

        .alert(item: $result) { result in

            switch result {

            case .added:

                return Alert(
                    title: Text("Hozzáadva"),
                    message: Text("A hozzávalók hozzáadva a bevásárlólistához."),
                    dismissButton: .cancel(Text("OK"))
                )

            case .nothingToAdd:

                return Alert(
                    title: Text("Minden van otthon"),
                    message: Text("A recept minden hozzávalója már szerepel az otthoni készletben."),
                    dismissButton: .cancel(Text("OK"))
                )
            }
        }
    }

    private func addIngredientsToList() {

        guard let list = selectedList else { return }

        var addedItems = false

        for ingredient in recipe.ingredients {

            // ellenőrizzük hogy van-e otthon
            let alreadyAtHome = pantryItems.contains {
                $0.name.lowercased() ==
                ingredient.name.lowercased()
            }

            // ha van otthon, nem adjuk hozzá
            if alreadyAtHome { continue }

            let item = ShoppingItem(
                name: ingredient.name,
                quantity: ingredient.quantity,
                category: .other
            )

            item.list = list

            context.insert(item)

            addedItems = true
        }

        if addedItems {
            result = .added
        } else {
            result = .nothingToAdd
        }
    }
}
