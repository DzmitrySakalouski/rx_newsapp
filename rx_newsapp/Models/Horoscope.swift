import UIKit
import Foundation

struct Horoscope: Decodable, Encodable {
    let today: HoroscopeDateRangeData?
    let yesterday: HoroscopeDateRangeData?
    let tomorrow: HoroscopeDateRangeData?
    let week: HoroscopeDateRangeData?
    let month: HoroscopeDateRangeData?
    let year: HoroscopeDateRangeData?
}

struct HoroscopeDateRangeData: Decodable, Encodable {
    let sign: String
    let locale: String
    let love_rate: Int
    let health_rate: Int
    let career_rate: Int
    let overall_desc: String
    let love_desc: String
    let health_desc: String
    let career_desc: String
}

struct HoroscopePeriodChartData {
    let value: Double
    let name: String
    let chartColor: UIColor
}

extension Horoscope {
    static var empty: Horoscope {
        let emptyDateRange = HoroscopeDateRangeData(sign: "", locale: "", love_rate: 0, health_rate: 0, career_rate: 0, overall_desc: "", love_desc: "", health_desc: "", career_desc: "")
        return Horoscope(today: emptyDateRange, yesterday: emptyDateRange, tomorrow: emptyDateRange, week: emptyDateRange, month: emptyDateRange, year: emptyDateRange)
    }
}

extension HoroscopeDateRangeData {
    static var empty: HoroscopeDateRangeData {
        return HoroscopeDateRangeData(sign: "", locale: "", love_rate: 0, health_rate: 0, career_rate: 0, overall_desc: "", love_desc: "", health_desc: "", career_desc: "")
    }
}
