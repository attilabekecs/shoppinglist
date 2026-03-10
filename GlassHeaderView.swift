import SwiftUI

struct GlassHeaderView: View {

    var title: String
    @Binding var searchText: String

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            Text(title)
                .font(.largeTitle.bold())

            HStack {

                Image(systemName: "magnifyingglass")

                TextField("Termék keresése", text: $searchText)
            }
            .padding(10)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding()
        .background(.ultraThinMaterial)
    }
}
