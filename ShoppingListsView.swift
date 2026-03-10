import SwiftUI
import SwiftData

struct ShoppingListsView: View {

    @Environment(\.modelContext) private var context
    @Query private var lists: [ShoppingList]

    var body: some View {

        NavigationStack {

            List {

                ForEach(lists) { list in

                    NavigationLink(list.title) {
                        ShoppingListDetailView(list: list)
                    }
                }
            }
            .navigationTitle("Bevásárlólisták")
            .toolbar {

                Button {

                    let list = ShoppingList(
                        title: "Új lista",
                        store: .lidl
                    )

                    context.insert(list)

                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}
