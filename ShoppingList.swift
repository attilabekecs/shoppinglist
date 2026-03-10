import Foundation
import SwiftData

@Model
final class ShoppingList {

    var id: UUID
    var title: String
    var storeRaw: String
    var createdAt: Date

    @Relationship(deleteRule: .cascade)
    var items: [ShoppingItem] = []

    var store: StoreType {
        get { StoreType(rawValue: storeRaw) ?? .other }
        set { storeRaw = newValue.rawValue }
    }

    init(
        title: String,
        store: StoreType
    ) {
        self.id = UUID()
        self.title = title
        self.storeRaw = store.rawValue
        self.createdAt = .now
    }
}
