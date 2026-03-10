import SwiftUI
import SwiftData

struct ShoppingListsView: View {

    @Environment(\.modelContext) private var context
    @Query private var lists: [ShoppingList]

    var body: some View {

        NavigationStack {

            ZStack {

                ScrollView {

                    LazyVStack(spacing: 16) {

                        ForEach(lists) { list in

                            NavigationLink {

                                ShoppingListDetailView(list: list)

                            } label: {

                                listCard(list)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }

                // Floating add button
                VStack {

                    Spacer()

                    HStack {

                        Spacer()

                        Button {

                            let list = ShoppingList(
                                title: "Új lista",
                                store: .lidl
                            )

                            context.insert(list)

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

            .navigationTitle("Bevásárlólisták")
        }
    }

    // MARK: - Card

    private func listCard(_ list: ShoppingList) -> some View {

        HStack {

            VStack(alignment: .leading, spacing: 6) {

                Text(list.title)
                    .font(.headline)

                HStack(spacing: 6) {

                    Text(list.store.rawValue)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Text("•")

                    Text("\(list.items.count) termék")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
        )
    }
}
