import Foundation

enum ProductCategory: String, CaseIterable, Codable, Identifiable {

    case vegetables = "Zöldség"
    case fruits = "Gyümölcs"
    case bakery = "Pékáru"
    case meat = "Hús"
    case dairy = "Tejtermék"
    case frozen = "Fagyasztott"
    case drinks = "Ital"
    case snacks = "Snack"

    case pantry = "Alapanyag"
    case household = "Háztartás"
    case baby = "Baba"
    case pharmacy = "Gyógyszertár"

    case other = "Egyéb"

    var id: String { rawValue }
}
