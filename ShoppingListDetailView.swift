import SwiftUI
import SwiftData

struct ShoppingListDetailView: View {

    @Environment(\.modelContext) private var context
    var list: ShoppingList

    @State private var showScanner = false
    @State private var showEditor = false
    @State private var editingItem: ShoppingItem?

    var body: some View {

        VStack {

    QuickAddView(list: list)

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

                // Termék szerkesztése tapra
                .onTapGesture {

                    editingItem = item
                    showEditor = true
                }
            }
        }
        .navigationTitle(list.title)

        .toolbar {

            ToolbarItemGroup(placement: .topBarTrailing) {

                // ➕ Új termék
                Button {

                    editingItem = nil
                    showEditor = true

                } label: {
                    Image(systemName: "plus")
                }

                // 📷 Scanner
                Button {
                    showScanner = true
                } label: {
                    Image(systemName: "barcode.viewfinder")
                }

                // 💰 Ár összehasonlítás
                NavigationLink {

                    PriceComparisonView(list: list)

                } label: {

                    Image(systemName: "chart.bar")
                }
            }
        }

        // 📷 Scanner
        .sheet(isPresented: $showScanner) {

            BarcodeScannerView { code in

                showScanner = false

                Task {

                    let name = await ProductLookupService.fetchProduct(barcode: code)

                    let item = ShoppingItem(
                        name: name ?? "Ismeretlen termék"
                    )

                    item.list = list
                    context.insert(item)
                }
            }
        }

        // ✏️ Termék szerkesztő
        .sheet(isPresented: $showEditor) {

            ItemEditorView(
                list: list,
                item: editingItem
            )
        }
    }
}
