import UIKit
import Foundation

class UserData: Decodable, Encodable {
    var id: String = "ios-123"
    var name: String = ""
    var gender: String = "male"
    var birthday: String = ""
    var email: String = ""
    var timeOfBirth: String = ""
    var placeOfBirth: String = ""
    
    init(name: String, birthday: String, email: String, timeOfBirth: String, placeOfBirth: String) {
        self.name = name
        self.birthday = birthday
        self.email = email
        self.timeOfBirth = timeOfBirth
        self.placeOfBirth = placeOfBirth
        self.id = "iOS-\(UIDevice.current.identifierForVendor!.uuidString)"
    }
    
    private enum CodingKeys: String, CodingKey {
        case name = "fullname"
        case id
        case gender
        case birthday = "date_of_birth"
        case timeOfBirth = "time_of_birth"
        case placeOfBirth = "place_of_birth"
        case email
    }
}
