import Foundation
import SwiftData

@Model
final class PantryItem {

    var id: UUID
    var name: String
    var quantity: String

    init(name: String, quantity: String) {
        self.id = UUID()
        self.name = name
        self.quantity = quantity
    }
}
