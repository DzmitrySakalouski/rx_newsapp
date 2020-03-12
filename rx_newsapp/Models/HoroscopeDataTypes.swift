//
//  HoroscopeDataTypes.swift
//  rx_newsapp
//
//  Created by Dzmitry  Sakalouski  on 3/12/20.
//  Copyright © 2020 Dzmitry  Sakalouski . All rights reserved.
//

import Foundation
enum HoroscopeDataTypes: String {
    case overall
    case love
    case health
    case career
    
    func getTypeTitle(signName: String?) -> String {
        switch self {
        case .overall:
            return "Overall \(signName ?? "") Horoscope"
        case .love:
            return "Love and Passion"
        case .health:
            return "Health"
        case .career:
            return "Career and money"
        }
    }
}
