import Foundation

struct OpenFoodFactsResponse: Codable {

    let product: OpenFoodFactsProduct?
}

struct OpenFoodFactsProduct: Codable {

    let product_name: String?
}
