import SwiftUI
import SwiftData

struct PriceComparisonView: View {

    var list: ShoppingList

    @Query private var prices: [ProductPrice]

    var body: some View {

        List {

            ForEach(StoreType.allCases) { store in

                let total = PriceService.totalPrice(
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
                }
            }
        }
        .navigationTitle("Ár összehasonlítás")
    }
}
