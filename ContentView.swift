import SwiftUI

struct ContentView: View {

    var body: some View {

        TabView {

            ShoppingListsView()
                .tabItem {
                    Label("Listák", systemImage: "cart")
                }

            RecipesView()
                .tabItem {
                    Label("Receptek", systemImage: "fork.knife")
                }

            PantryView()
                .tabItem {
                    Label("Készlet", systemImage: "cabinet")
                }
        }
    }
}
