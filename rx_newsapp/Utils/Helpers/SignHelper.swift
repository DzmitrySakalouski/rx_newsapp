
import Foundation

class SignHelper {
    static func getDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        return dateFormatter.date(from: dateString)
    }
    
    static func getSignFromDateRange(dateString: String) -> ZodiacSign? {
        guard let date = self.getDate(dateString: dateString) else { return nil }
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMMM"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        
        let monthValue = monthFormatter.string(from: date)
        let dateValue = Int(dateFormatter.string(from: date))!
        
        switch monthValue {
        case "March":
            if 21...31 ~= dateValue {
                return ZodiacSigns.aries.instance
            } else {
                return ZodiacSigns.pisces.instance
            }
        case "April":
            if 1...19 ~= dateValue {
                return ZodiacSigns.aries.instance
            } else {
                return ZodiacSigns.taurus.instance
            }
        case "May":
            if 1...20 ~= dateValue {
                return ZodiacSigns.taurus.instance
            } else {
                return ZodiacSigns.gemini.instance
            }
        case "June":
            if 1...20 ~= dateValue {
                return ZodiacSigns.gemini.instance
            } else {
                return ZodiacSigns.cancer.instance
            }
        case "July":
            if 1...22 ~= dateValue {
                return ZodiacSigns.cancer.instance
            } else {
                return ZodiacSigns.leo.instance
            }
        case "August":
            if 1...22 ~= dateValue {
                return ZodiacSigns.leo.instance
            } else {
                return ZodiacSigns.virgo.instance
            }
        case "September":
            if 1...22 ~= dateValue {
                return ZodiacSigns.virgo.instance
            } else {
                return ZodiacSigns.libra.instance
            }
        case "October":
            if 1...22 ~= dateValue {
                return ZodiacSigns.libra.instance
            } else {
                return ZodiacSigns.scorpio.instance
            }
        case "November":
            if 1...21 ~= dateValue {
                return ZodiacSigns.scorpio.instance
            } else {
                return ZodiacSigns.saggitarius.instance
            }
        case "December":
            if 1...21 ~= dateValue {
                return ZodiacSigns.saggitarius.instance
            } else {
                return ZodiacSigns.capricorn.instance
            }
        case "January":
            if 1...19 ~= dateValue {
                return ZodiacSigns.capricorn.instance
            } else {
                return ZodiacSigns.aquarius.instance
            }
        case "February":
            if 1...18 ~= dateValue {
                return ZodiacSigns.aquarius.instance
            } else {
                return ZodiacSigns.pisces.instance
            }
        default:
            return nil
        }
    }
}

