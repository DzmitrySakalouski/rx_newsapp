
import Foundation

class CompatibilityViewModel {
    private static var instance: CompatibilityViewModel?
    private var compatibilityModel: CompatipilityMainInstamce?
    
    static func shared() -> CompatibilityViewModel {
        if instance == nil {
            instance = CompatibilityViewModel()
            instance?.compatibilityModel = getCompatipilityMainInstamce()
        }
        
        return instance!
    }
    
    private static func getCompatipilityMainInstamce() -> CompatipilityMainInstamce? {
        if let url = Bundle.main.url(forResource: "compatibility", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(CompatipilityMainInstamce.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        
        return CompatipilityMainInstamce.empty
    }
}
