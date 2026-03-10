import Foundation
import SwiftData

@Model
final class ProductPrice {

    var id: UUID
    var productName: String
    var storeRaw: String
    var price: Double

    var store: StoreType {
        get { StoreType(rawValue: storeRaw) ?? .other }
        set { storeRaw = newValue.rawValue }
    }

    init(
        productName: String,
        store: StoreType,
        price: Double
    ) {
        self.id = UUID()
        self.productName = productName
        self.storeRaw = store.rawValue
        self.price = price
    }
}
