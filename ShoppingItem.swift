import Foundation
import SwiftData

@Model
final class ShoppingItem {

    var id: UUID
    var name: String
    var quantity: String
    var categoryRaw: String
    var isChecked: Bool

    var list: ShoppingList?

    var category: ProductCategory {
        get { ProductCategory(rawValue: categoryRaw) ?? .other }
        set { categoryRaw = newValue.rawValue }
    }

    init(
        name: String,
        quantity: String = "",
        category: ProductCategory = .other
    ) {
        self.id = UUID()
        self.name = name
        self.quantity = quantity
        self.categoryRaw = category.rawValue
        self.isChecked = false
    }
}
