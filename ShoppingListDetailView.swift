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

        ZStack {

            VStack(spacing: 0) {

                GlassHeaderView(
                    title: list.title,
                    searchText: $searchText
                )

                QuickAddView(list: list)

                ScrollView {

                    LazyVStack(spacing: 20) {

                        ForEach(StoreLayoutService.groupedItems(for: list)) { group in

                            let filtered = filteredItems(group.items)

                            if !filtered.isEmpty {

                                VStack(alignment: .leading, spacing: 12) {

                                    // MARK: Category Header

                                    Text(group.category.rawValue.uppercased())
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.secondary)
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
            }

            // MARK: Floating Add Button

            VStack {

                Spacer()

                HStack {

                    Spacer()

                    Button {

                        editingItem = nil
                        activeSheet = .editor

                    } label: {

                        Image(systemName: "plus")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(.blue)
                            .clipShape(Circle())
                            .shadow(radius: 8)
                    }
                    .padding()
                }
            }
        }

        .toolbar {

            ToolbarItemGroup(placement: .topBarTrailing) {

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

    // MARK: Item Card

    private func itemCard(_ item: ShoppingItem) -> some View {

        HStack(spacing: 16) {

            // Product image

            if let data = item.imageData,
               let uiImage = UIImage(data: data) {

                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 52, height: 52)
                    .clipShape(RoundedRectangle(cornerRadius: 14))

            } else {

                Text(ProductIconService.icon(for: item.name))
                    .font(.system(size: 28))
                    .frame(width: 52, height: 52)
            }

            // Checkbox

            Button {

                withAnimation(.spring(response: 0.25)) {
                    item.isChecked.toggle()
                }

            } label: {

                Image(systemName:
                    item.isChecked
                    ? "checkmark.circle.fill"
                    : "circle"
                )
                .font(.title2)
            }
            .buttonStyle(.plain)

            // Item Text

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

    // MARK: Search Filter

    private func filteredItems(_ items: [ShoppingItem]) -> [ShoppingItem] {

        if searchText.isEmpty {
            return items
        }

        return items.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
}
