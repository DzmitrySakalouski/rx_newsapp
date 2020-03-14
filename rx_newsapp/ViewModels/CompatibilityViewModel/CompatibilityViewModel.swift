import RxSwift
import RxCocoa
import Foundation

class CompatibilityViewModel {
    private static var instance: CompatibilityViewModel?
    private var compatibilityModel: CompatipilityMainInstamce?
    
    var selectedSignsForComatibility = BehaviorRelay<[ZodiacSign]>(value: [ZodiacSign]())
    
    var selectedSignsCompatibilityData = BehaviorRelay<SignForCompatibilityCompare>(value: SignForCompatibilityCompare.empty)
    
    static func shared() -> CompatibilityViewModel {
        if instance == nil {
            instance = CompatibilityViewModel()
        }
        
        return instance!
    }
    
    private func getCompatipilityMainInstamce() -> CompatipilityMainInstamce? {
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
    
    func getCompatibilitySignData() {        
        guard let allCompatibilities = self.getCompatipilityMainInstamce()?.signCompatibilities else {
            print("NI DATA")
            return
        }
        
        let selectedSignsForCompatibility = selectedSignsForComatibility.value
        
        let currentSignCompatibilities = allCompatibilities.filter{ $0.sign == selectedSignsForCompatibility[0].name }
        let allCompatibilitiesForCurrentSign = currentSignCompatibilities[0].сompatibility
        let selectedSignsCompatibility = allCompatibilitiesForCurrentSign.filter{ $0.sign == selectedSignsForCompatibility[1].name }[0]
        self.selectedSignsCompatibilityData.accept(selectedSignsCompatibility)
    }
}
