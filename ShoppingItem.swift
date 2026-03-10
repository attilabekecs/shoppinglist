import SwiftUI
import SwiftData

enum ActiveSheet: Identifiable {
    case scanner
    case editor
    case quickEditor

    var id: Int { hashValue }
}

struct ShoppingListDetailView: View {

    @Environment(\.modelContext) private var context
    var list: ShoppingList

    @State private var editingItem: ShoppingItem?
    @State private var activeSheet: ActiveSheet?

    var body: some View {

        VStack(spacing: 0) {

            QuickAddView(list: list)

            List {

                ForEach(StoreLayoutService.groupedItems(for: list), id: \.category) { group in

                    Section(group.category.rawValue) {

                        ForEach(group.items) { item in

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
                                .buttonStyle(.plain)

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.name)

                                    if !item.quantity.isEmpty {
                                        Text(item.quantity)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                }

                                Spacer()
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                editingItem = item
                                activeSheet = .editor
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(list.title)

        .toolbar {

            ToolbarItemGroup(placement: .topBarTrailing) {

                Button {
                    editingItem = nil
                    activeSheet = .editor
                } label: {
                    Image(systemName: "plus")
                }

                Button {
                    activeSheet = .scanner
                } label: {
                    Image(systemName: "barcode.viewfinder")
                }

                Button {
                    activeSheet = .quickEditor
                } label: {
                    Image(systemName: "slider.horizontal.3")
                }

                NavigationLink {
                    PriceComparisonView(list: list)
                } label: {
                    Image(systemName: "chart.bar")
                }
            }
        }

        .sheet(item: $activeSheet) { sheet in

            switch sheet {

            case .scanner:

                BarcodeScannerView { code in
                    activeSheet = nil

                    Task {
                        let name = await ProductLookupService.fetchProduct(barcode: code)

                        let item = ShoppingItem(
                            name: name ?? "Ismeretlen termék"
                        )

                        item.list = list
                        context.insert(item)
                    }
                }

            case .editor:

                ItemEditorView(
                    list: list,
                    item: editingItem
                )

            case .quickEditor:

                QuickAddEditorView()
            }
        }
    }
}
