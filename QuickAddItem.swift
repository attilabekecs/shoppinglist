import Foundation
import SwiftData

@Model
final class QuickAddItem {

    var name: String
    var categoryRaw: String

    var category: ProductCategory {
        get { ProductCategory(rawValue: categoryRaw) ?? .other }
        set { categoryRaw = newValue.rawValue }
    }

    init(name: String, category: ProductCategory = .other) {
        self.name = name
        self.categoryRaw = category.rawValue
    }
}
