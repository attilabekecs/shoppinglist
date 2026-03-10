import Foundation
import SwiftData

struct PriceService {

    static func totalPrice(
        for list: ShoppingList,
        prices: [ProductPrice],
        store: StoreType
    ) -> Double {

        var total: Double = 0

        for item in list.items {

            if let price = prices.first(
                where: {
                    $0.productName.lowercased() ==
                    item.name.lowercased()
                    && $0.store == store
                }
            ) {

                total += price.price
            }
        }

        return total
    }
}
