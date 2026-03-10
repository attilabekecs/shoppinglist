import SwiftUI
import SwiftData

struct ShoppingListDetailView: View {

    @Environment(\.modelContext) private var context

    var list: ShoppingList

    @State private var showScanner = false

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

            ToolbarItemGroup(placement: .topBarTrailing) {

                // ➕ új termék
                Button {

                    let item = ShoppingItem(name: "Új termék")
                    item.list = list

                    context.insert(item)

                } label: {
                    Image(systemName: "plus")
                }

                // 📷 vonalkód scanner
                Button {

                    showScanner = true

                } label: {
                    Image(systemName: "barcode.viewfinder")
                }
            }
        }

        // 📷 Scanner megnyitása
        .sheet(isPresented: $showScanner) {

            BarcodeScannerView { code in

                let item = ShoppingItem(
                    name: "Termék \(code)"
                )

                item.list = list

                context.insert(item)
            }
        }
    }
}
