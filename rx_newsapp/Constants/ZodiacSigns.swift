
import Foundation

enum ZodiacSigns {
    case aries
    case taurus
    case gemini
    case cancer
    case leo
    case virgo
    case libra
    case scorpio
    case saggitarius
    case capricorn
    case aquarius
    case pisces
    
    var instance: ZodiacSign {
        switch self {
        case .aries: return ZodiacSign(name: "aries", displayName: "Aries", dateRange: "21 March - 19 April", dateRangeShort: "21 Mar - 19 Apr", image: "aries")
        case .taurus: return ZodiacSign(name: "taurus", displayName: "Taurus", dateRange: "20 April - 20 May", dateRangeShort: "21 Apr - 19 May", image: "taurus")
        case .gemini: return ZodiacSign(name: "gemini", displayName: "Gemini", dateRange: "21 May - 20 June", dateRangeShort: "21 May - 20 Jun", image: "gemini")
        case .cancer: return ZodiacSign(name: "cancer", displayName: "Cancer", dateRange: "21 June - 22 July", dateRangeShort: "21 Jun - 22 Jul", image: "cancer")
        case .leo: return ZodiacSign(name: "leo", displayName: "Leo", dateRange: "23 July - 22 August", dateRangeShort: "23 Jul - 22 Aug", image: "leo")
        case .virgo: return ZodiacSign(name: "virgo", displayName: "Virgo", dateRange: "23 August - 22 September", dateRangeShort: "23 Aug - 22 Sep", image: "virgo")
        case .libra: return ZodiacSign(name: "libra", displayName: "Libra", dateRange: "23 September - 22 October", dateRangeShort: "23 Sep - 22 Oct", image: "libra")
        case .scorpio: return ZodiacSign(name: "scorpio", displayName: "Scorpio", dateRange: "23 October - 21 November", dateRangeShort: "23 Oct - 21 Nov", image: "scorpio")
        case .saggitarius: return ZodiacSign(name: "saggitarius", displayName: "Saggitarius", dateRange: "22 November - 21 December", dateRangeShort: "22 Nov - 21 Dec", image: "saggitarius")
        case .capricorn: return ZodiacSign(name: "capricorn", displayName: "Capricorn", dateRange: "22 December - 19 January", dateRangeShort: "22 Dec - 19 Jan", image: "capricorn")
        case .aquarius: return ZodiacSign(name: "aquarius", displayName: "Aquarius", dateRange: "20 January - 18 February", dateRangeShort: "20 Jan - 18 Feb", image: "aquarius")
        case .pisces: return ZodiacSign(name: "pisces", displayName: "Pisces", dateRange: "19 January - 20 March", dateRangeShort: "19 Jan - 20 Mar", image: "pisces")
        }
    }
}

let zodiacSignsArray: [ZodiacSign] = [
    ZodiacSigns.aries.instance,
    ZodiacSigns.taurus.instance,
    ZodiacSigns.gemini.instance,
    ZodiacSigns.cancer.instance,
    ZodiacSigns.leo.instance,
    ZodiacSigns.virgo.instance,
    ZodiacSigns.libra.instance,
    ZodiacSigns.scorpio.instance,
    ZodiacSigns.saggitarius.instance,
    ZodiacSigns.capricorn.instance,
    ZodiacSigns.aquarius.instance,
    ZodiacSigns.pisces.instance,
]
