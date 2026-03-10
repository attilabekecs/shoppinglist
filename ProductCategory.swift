import Foundation

enum ProductCategory: String, CaseIterable, Codable, Identifiable {

    case vegetables = "Zöldség"
    case fruits = "Gyümölcs"
    case meat = "Hús"
    case dairy = "Tejtermék"
    case bakery = "Pékáru"
    case frozen = "Fagyasztott"
    case drinks = "Ital"
    case snacks = "Snack"
    case household = "Háztartás"
    case other = "Egyéb"

    var id: String { rawValue }
}
