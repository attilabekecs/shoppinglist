import Foundation

struct ProductIconService {

    static func icon(for name: String) -> String {

        let text = name.lowercased()

        if contains(text, ["tej"]) { return "🥛" }
        if contains(text, ["sajt"]) { return "🧀" }
        if contains(text, ["vaj"]) { return "🧈" }
        if contains(text, ["joghurt","kefir"]) { return "🥣" }

        if contains(text, ["kenyér","kenyer","zsemle","kifli"]) { return "🍞" }

        if contains(text, ["alma"]) { return "🍎" }
        if contains(text, ["banán","banan"]) { return "🍌" }
        if contains(text, ["narancs"]) { return "🍊" }
        if contains(text, ["citrom"]) { return "🍋" }

        if contains(text, ["paradicsom"]) { return "🍅" }
        if contains(text, ["répa","repa"]) { return "🥕" }
        if contains(text, ["saláta","salata"]) { return "🥬" }

        if contains(text, ["csirke","csirkemell"]) { return "🍗" }
        if contains(text, ["marha","sertés","sertes"]) { return "🥩" }

        if contains(text, ["pizza"]) { return "🍕" }
        if contains(text, ["chips"]) { return "🍟" }
        if contains(text, ["csoki","csokoládé","csokolade"]) { return "🍫" }

        if contains(text, ["víz","viz"]) { return "💧" }
        if contains(text, ["cola","kóla","kola"]) { return "🥤" }
        if contains(text, ["sör","sor"]) { return "🍺" }

        if contains(text, ["wc papír","wc papir"]) { return "🧻" }
        if contains(text, ["mosószer","mososzer"]) { return "🧴" }

        return "🛒"
    }

    private static func contains(_ text: String, _ words: [String]) -> Bool {

        for word in words {
            if text.contains(word) {
                return true
            }
        }

        return false
    }
}
