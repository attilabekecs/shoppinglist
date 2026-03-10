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
    @State private var searchText: String = ""

    var body: some View {

        VStack(spacing: 0) {

            QuickAddView(list: list)

            List {

                ForEach(StoreLayoutService.groupedItems(for: list), id: \.category) { group in

                    let filtered = filteredItems(group.items)

                    if !filtered.isEmpty {

                        Section(group.category.rawValue) {

                            ForEach(filtered) { item in

                                HStack(spacing: 12) {

                                    // 📷 Termék kép
                                    if let data = item.imageData,
                                       let uiImage = UIImage(data: data) {

                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 40, height: 40)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))

                                    } else {

                                        Image(systemName: "cart")
                                            .frame(width: 40)
                                    }

                                    // ✔️ Checkbox
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

                                    // 📝 Termék adatok
                                    VStack(alignment: .leading, spacing: 4) {

                                        Text(item.name)
                                            .strikethrough(item.isChecked)
                                            .foregroundStyle(
                                                item.isChecked ? .secondary : .primary
                                            )

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
            .searchable(text: $searchText, prompt: "Termék keresése")
        }

        .navigationTitle(list.title)

        .toolbar {

            ToolbarItemGroup(placement: .topBarTrailing) {

                // ➕ Új termék
                Button {
                    editingItem = nil
                    activeSheet = .editor
                } label: {
                    Image(systemName: "plus")
                }

                // 📷 Vonalkód scanner
                Button {
                    activeSheet = .scanner
                } label: {
                    Image(systemName: "barcode.viewfinder")
                }

                // ⚡ QuickAdd szerkesztő
                Button {
                    activeSheet = .quickEditor
                } label: {
                    Image(systemName: "slider.horizontal.3")
                }

                // 💰 Ár összehasonlítás
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

    // 🔎 Keresési szűrő
    private func filteredItems(_ items: [ShoppingItem]) -> [ShoppingItem] {

        if searchText.isEmpty {
            return items
        }

        return items.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
}
