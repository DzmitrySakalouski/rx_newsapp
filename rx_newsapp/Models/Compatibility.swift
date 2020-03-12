
import Foundation

struct CompatipilityMainInstamce: Decodable {
    let signCompatibilities: [SignForCompatibility]
}

struct SignForCompatibility: Decodable {
    let sign: String
    let сompatibility: [SignForCompatibilityCompare]
}

struct SignForCompatibilityCompare: Decodable {
    let sign: String
    let percent: Int
    let counters: Counters
    let details: [Details]
}

struct Counters: Decodable {
    let love: Int
    let passion: Int
    let trust: Int
}

struct Details: Decodable {
    let locale: String
    let marriage: String
    let sexual: String
    let wealth_and_family: String
    let children: String
}

extension Details {
    static var empty = Details(locale: "", marriage: "", sexual: "", wealth_and_family: "", children: "")
}

extension Counters {
    static var empty = Counters(love: 0, passion: 0, trust: 0)
}

extension SignForCompatibilityCompare {
    static var empty = SignForCompatibilityCompare(sign: "", percent: 0, counters: Counters.empty, details: [Details.empty])
}

extension SignForCompatibility {
    static var empty = SignForCompatibility(sign: "", сompatibility: [SignForCompatibilityCompare.empty])
}

extension CompatipilityMainInstamce {
    static var empty = CompatipilityMainInstamce(signCompatibilities: [SignForCompatibility.empty])
}
