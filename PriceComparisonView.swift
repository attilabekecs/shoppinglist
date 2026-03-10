import SwiftUI
import SwiftData

struct PriceComparisonView: View {

    var list: ShoppingList

    @Query private var prices: [ProductPrice]

    var body: some View {

        let cheapest = PriceEngine.cheapestStore(
            for: list,
            prices: prices
        )

        List {

            Section("Boltok") {

                ForEach(StoreType.allCases) { store in

                    let total = PriceEngine.totalPrice(
                        for: list,
                        prices: prices,
                        store: store
                    )

                    HStack {

                        Text(store.rawValue)

                        Spacer()

                        Text(
                            total,
                            format: .currency(code: "HUF")
                        )

                        if store == cheapest {

                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                        }
                    }
                }
            }

            if let cheapest {

                Section {

                    HStack {

                        Text("Legolcsóbb bolt")

                        Spacer()

                        Text(cheapest.rawValue)
                            .fontWeight(.semibold)
                    }
                }
            }
        }

        .navigationTitle("Ár összehasonlítás")
    }
}
