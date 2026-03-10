import SwiftUI
import SwiftData

struct RecipesView: View {

    @Environment(\.modelContext) private var context
    @Query private var recipes: [Recipe]

    var body: some View {

        NavigationStack {

            List {

                ForEach(recipes) { recipe in

                    NavigationLink {

                        RecipeDetailView(recipe: recipe)

                    } label: {

                        Text(recipe.name)
                    }
                }
            }
            .navigationTitle("Receptek")

            .toolbar {

                ToolbarItem(placement: .topBarTrailing) {

                    Button {

                        let recipe = Recipe(name: "Új recept")
                        context.insert(recipe)

                    } label: {

                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}
