import Foundation

struct PriceEngine {

    static func totalPrice(
        for list: ShoppingList,
        prices: [ProductPrice],
        store: StoreType
    ) -> Double {

        var total: Double = 0

        for item in list.items {

            if let price = prices.first(where: {

                $0.productName.lowercased() ==
                item.name.lowercased()
                && $0.store == store

            }) {

                total += price.price
            }
        }

        return total
    }

    static func cheapestStore(
        for list: ShoppingList,
        prices: [ProductPrice]
    ) -> StoreType? {

        var cheapest: StoreType?
        var lowestPrice = Double.infinity

        for store in StoreType.allCases {

            let total = totalPrice(
                for: list,
                prices: prices,
                store: store
            )

            if total > 0 && total < lowestPrice {

                lowestPrice = total
                cheapest = store
            }
        }

        return cheapest
    }
}
