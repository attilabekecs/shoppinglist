import SwiftUI
import SwiftData

struct RecipeDetailView: View {

    @Environment(\.modelContext) private var context

    var recipe: Recipe

    @Query private var lists: [ShoppingList]

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
    }

    private func addIngredientsToList() {

        guard let list = selectedList else { return }

        for ingredient in recipe.ingredients {

            let item = ShoppingItem(
                name: ingredient.name,
                quantity: ingredient.quantity,
                category: .other
            )

            item.list = list

            context.insert(item)
        }
    }
}
