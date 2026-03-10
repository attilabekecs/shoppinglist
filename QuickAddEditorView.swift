import SwiftUI
import SwiftData

struct QuickAddEditorView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @Query private var quickItems: [QuickAddItem]

    @State private var name: String = ""
    @State private var category: ProductCategory = .other

    var body: some View {

        NavigationStack {

            List {

                Section("Új gyors termék") {

                    TextField("Termék neve", text: $name)

                    Picker("Kategória", selection: $category) {

                        ForEach(ProductCategory.allCases) { cat in
                            Text(cat.rawValue)
                                .tag(cat)
                        }
                    }

                    Button {

                        addItem()

                    } label: {

                        Label("Hozzáadás", systemImage: "plus")
                    }
                    .disabled(name.isEmpty)
                }

                Section("Gyors termékek") {

                    ForEach(quickItems) { item in

                        HStack {

                            Text(item.name)

                            Spacer()

                            Text(item.category.rawValue)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }

            .navigationTitle("Gyors termékek")

            .toolbar {

                ToolbarItem(placement: .topBarTrailing) {

                    Button("Kész") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func addItem() {

        let item = QuickAddItem(
            name: name,
            category: category
        )

        context.insert(item)

        name = ""
        category = .other
    }

    private func deleteItems(at offsets: IndexSet) {

        for index in offsets {
            context.delete(quickItems[index])
        }
    }
}
