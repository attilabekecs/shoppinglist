import SwiftUI

struct ContentView: View {

    var body: some View {

        TabView {

            NavigationStack {
                ShoppingListsView()
            }
            .tabItem {
                Label("Listák", systemImage: "cart.fill")
            }

            NavigationStack {
                RecipesView()
            }
            .tabItem {
                Label("Receptek", systemImage: "fork.knife")
            }

            NavigationStack {
                PantryView()
            }
            .tabItem {
                Label("Készlet", systemImage: "cabinet.fill")
            }
        }
    }
}
