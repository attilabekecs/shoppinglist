import Foundation

struct ProductClassifierService {

    static func category(for name: String) -> ProductCategory {

        let text = name.lowercased()

        // Gyümölcs

        if contains(text, [
            "alma","banán","banan","körte","korte","narancs","citrom",
            "mandarin","eper","szőlő","szolo","málna","malna"
        ]) {
            return .fruits
        }

        // Zöldség

        if contains(text, [
            "krumpli","burgonya","répa","repa","hagyma","fokhagyma",
            "paradicsom","paprika","uborka","saláta","salata"
        ]) {
            return .vegetables
        }

        // Tejtermék

        if contains(text, [
            "tej","sajt","vaj","joghurt","túró","turo","tejszín",
            "tejszin","kefir"
        ]) {
            return .dairy
        }

        // Hús

        if contains(text, [
            "csirke","csirkemell","marha","sertés","sertes",
            "kolbász","kolbasz","sonka","szalámi","szalami"
        ]) {
            return .meat
        }

        // Pékáru

        if contains(text, [
            "kenyér","kenyer","zsemle","kifli","bagett","croissant"
        ]) {
            return .bakery
        }

        // Ital

        if contains(text, [
            "víz","viz","cola","kóla","kola","sör","bor","üdítő",
            "uditő","üdítőital","lé","juice"
        ]) {
            return .drinks
        }

        // Snack

        if contains(text, [
            "csoki","csokoládé","csokolade","chips","ropi",
            "keksz","süti","suti"
        ]) {
            return .snacks
        }

        // Háztartás

        if contains(text, [
            "wc papír","wc papir","papírtörlő","papirtorlo",
            "mosószer","mososzer","öblítő","oblito",
            "mosogatószer","mosogatoszer"
        ]) {
            return .household
        }

        // Baba

        if contains(text, [
            "pelenka","babaétel","babaetel","tápszer","tapszer"
        ]) {
            return .baby
        }

        // Gyógyszertár

        if contains(text, [
            "vitamin","gyógyszer","gyogyszer","fájdalomcsillapító",
            "fajdalomcsillapito","kötszer","kotszer"
        ]) {
            return .pharmacy
        }

        return .other
    }

    private static func contains(_ text: String, _ keywords: [String]) -> Bool {

        for word in keywords {
            if text.contains(word) {
                return true
            }
        }

        return false
    }
}
