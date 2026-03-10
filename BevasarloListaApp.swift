import SwiftUI
import SwiftData

@main
struct BevasarloListaApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [
    ShoppingList.self,
    ShoppingItem.self,
    ProductPrice.self,
    Recipe.self,
    RecipeIngredient.self,
    PantryItem.self,
    QuickAddItem.self
])
    }
}
