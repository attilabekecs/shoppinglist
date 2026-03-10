import Foundation

enum StoreType: String, CaseIterable, Codable, Identifiable {

    case lidl = "Lidl"
    case tesco = "Tesco"
    case aldi = "Aldi"
    case spar = "Spar"
    case auchan = "Auchan"
    case other = "Egyéb"

    var id: String { rawValue }
}
