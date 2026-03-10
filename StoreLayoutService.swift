import Foundation

struct StoreLayoutService {

    static func orderedCategories(for store: StoreType) -> [ProductCategory] {
        switch store {
        case .lidl:
            return [
                .vegetables,
                .fruits,
                .bakery,
                .meat,
                .dairy,
                .frozen,
                .drinks,
                .snacks,
                .household,
                .baby,
                .pharmacy,
                .pantry,
                .other
            ]

        case .tesco:
            return [
                .vegetables,
                .fruits,
                .bakery,
                .dairy,
                .meat,
                .frozen,
                .drinks,
                .snacks,
                .household,
                .baby,
                .pharmacy,
                .pantry,
                .other
            ]

        case .aldi:
            return [
                .vegetables,
                .fruits,
                .bakery,
                .meat,
                .dairy,
                .frozen,
                .drinks,
                .snacks,
                .household,
                .baby,
                .pharmacy,
                .pantry,
                .other
            ]

        case .spar:
            return [
                .vegetables,
                .fruits,
                .bakery,
                .meat,
                .dairy,
                .frozen,
                .drinks,
                .snacks,
                .household,
                .pantry,
                .baby,
                .pharmacy,
                .other
            ]

        case .auchan:
            return [
                .vegetables,
                .fruits,
                .bakery,
                .meat,
                .dairy,
                .frozen,
                .drinks,
                .snacks,
                .household,
                .baby,
                .pharmacy,
                .pantry,
                .other
            ]

        case .other:
            return ProductCategory.allCases
        }
    }

    static func groupedItems(for list: ShoppingList) -> [(category: ProductCategory, items: [ShoppingItem])] {
        let orderedCategories = orderedCategories(for: list.store)

        return orderedCategories.compactMap { category in
            let items = list.items.filter { $0.category == category }
            guard !items.isEmpty else { return nil }
            return (category: category, items: items)
        }
    }
}
