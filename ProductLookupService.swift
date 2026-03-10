import Foundation

struct ProductLookupService {

    static func fetchProduct(barcode: String) async -> String? {

        guard let url = URL(
            string: "https://world.openfoodfacts.org/api/v0/product/\(barcode).json"
        ) else { return nil }

        do {

            let (data, _) = try await URLSession.shared.data(from: url)

            let result = try JSONDecoder().decode(
                OpenFoodFactsResponse.self,
                from: data
            )

            return result.product?.product_name

        } catch {

            print("API error:", error)
            return nil
        }
    }
}
