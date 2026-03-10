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

                Button {

                    let item = ShoppingItem(name: "Új termék")
                    item.list = list
                    context.insert(item)

                } label: {
                    Image(systemName: "plus")
                }

                Button {
                    showScanner = true
                } label: {
                    Image(systemName: "barcode.viewfinder")
                }

                NavigationLink {
                    PriceComparisonView(list: list)
                } label: {
                    Image(systemName: "chart.bar")
                }
            }
        }

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
    }
}
