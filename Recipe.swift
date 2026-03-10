import Foundation
import SwiftData

@Model
final class Recipe {

    var id: UUID
    var name: String

    @Relationship(deleteRule: .cascade)
    var ingredients: [RecipeIngredient] = []

    init(name: String) {
        self.id = UUID()
        self.name = name
    }
}
