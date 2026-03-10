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

            ScrollView {

                LazyVStack(spacing: 20) {

                    ForEach(StoreLayoutService.groupedItems(for: list), id: \.category) { group in

                        let filtered = filteredItems(group.items)

                        if !filtered.isEmpty {

                            VStack(alignment: .leading, spacing: 12) {

                                // kategória cím
                                Text(group.category.rawValue)
                                    .font(.headline)
                                    .padding(.horizontal)

                                ForEach(filtered) { item in

                                    itemCard(item)
                                }
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
            .searchable(text: $searchText, prompt: "Termék keresése")
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

    // MARK: - Card UI

    private func itemCard(_ item: ShoppingItem) -> some View {

        HStack(spacing: 16) {

            if let data = item.imageData,
               let uiImage = UIImage(data: data) {

                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 52, height: 52)
                    .clipShape(RoundedRectangle(cornerRadius: 14))

            } else {

                Image(systemName: "cart")
                    .font(.system(size: 22))
                    .frame(width: 52, height: 52)
                    .background(.quaternary)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }

            Button {
                item.isChecked.toggle()
            } label: {
                Image(systemName:
                    item.isChecked
                    ? "checkmark.circle.fill"
                    : "circle"
                )
                .font(.title2)
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 4) {

                Text(item.name)
                    .font(.headline)
                    .strikethrough(item.isChecked)
                    .foregroundStyle(item.isChecked ? .secondary : .primary)

                if !item.quantity.isEmpty {

                    Text(item.quantity)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
        )
        .padding(.horizontal)
        .contentShape(Rectangle())
        .onTapGesture {
            editingItem = item
            activeSheet = .editor
        }
    }

    // MARK: - Keresési szűrő

    private func filteredItems(_ items: [ShoppingItem]) -> [ShoppingItem] {

        if searchText.isEmpty {
            return items
        }

        return items.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
}
