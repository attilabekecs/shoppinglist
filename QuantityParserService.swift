import Foundation

struct QuantityParserService {

    static func parse(_ text: String) -> (name: String, quantity: String) {

        let components = text.split(separator: " ")

        guard components.count > 1 else {
            return (text.capitalized, "")
        }

        let last = String(components.last!)

        if isQuantity(last) {

            let name = components.dropLast().joined(separator: " ").capitalized

            let quantity = formatQuantity(last)

            return (name, quantity)
        }

        return (text.capitalized, "")
    }

    private static func isQuantity(_ text: String) -> Bool {

        let numbers = CharacterSet.decimalDigits

        return text.rangeOfCharacter(from: numbers) != nil
    }

    private static func formatQuantity(_ text: String) -> String {

        let lower = text.lowercased()

        if lower.contains("kg") { return lower }
        if lower.contains("g") { return lower }
        if lower.contains("l") { return lower }
        if lower.contains("ml") { return lower }

        if Int(lower) != nil {
            return "\(lower) db"
        }

        return lower
    }
}
