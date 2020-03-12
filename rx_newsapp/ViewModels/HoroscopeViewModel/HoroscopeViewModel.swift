import RxCocoa
import RxSwift
import Foundation

struct HoroscopeViewModel {
    private static var instance: HoroscopeViewModel?
    let isPopupOpenSubject = BehaviorRelay<Bool>(value: false)
    var selectedSignSubject = BehaviorSubject<ZodiacSign>(value: ZodiacSigns.aries.instance)
    var selectedPeriodIdSubject = BehaviorRelay<Int>(value: 1)
    var horoscopeData = BehaviorRelay<Horoscope>(value: Horoscope.empty)
    let showLoading = BehaviorRelay<Bool>(value: true)
    
    var horoscopeSelectedPeriodData = BehaviorRelay<HoroscopeDateRangeData>(value: HoroscopeDateRangeData.empty)
    
    let disposeBag = DisposeBag()
    
    static func shared() -> HoroscopeViewModel {
        if instance == nil {
            instance = HoroscopeViewModel()
        }
        
        return instance!
    }
    
    func getHoroscopeData() {
        guard let selectedSign = try? selectedSignSubject.value() else { return }
        let url = URL(string: "https://horoplus.pro/api/horoscope/?sign=\(selectedSign.name)&locale=ru&date=2020-03-1")!
        let resource = Resource<Horoscope>(url: url, method: "GET")
        
        let selectedPeriodId: Int = selectedPeriodIdSubject.value
        
        URLRequest.load(resource: resource)
            .observeOn(MainScheduler.instance)
            .subscribe { response in
                guard let data = response.event.element else { return }
                self.horoscopeData.accept(data)
                self.getHoroscopePeriodData(by: selectedPeriodId)
                self.showLoading.accept(false)
           }.disposed(by: disposeBag)

    }
    
    func getHoroscopePeriodData(by periodId: Int) {
        let periodData: HoroscopeDateRangeData
        switch periodId {
            case 0:
                periodData = self.horoscopeData.value.yesterday ?? HoroscopeDateRangeData.empty
            case 1:
                periodData = self.horoscopeData.value.today ?? HoroscopeDateRangeData.empty
            case 2:
                periodData = self.horoscopeData.value.tomorrow ?? HoroscopeDateRangeData.empty
            case 3:
                periodData = self.horoscopeData.value.week ?? HoroscopeDateRangeData.empty
            case 4:
                periodData = self.horoscopeData.value.year ?? HoroscopeDateRangeData.empty
            default:
                periodData = self.horoscopeData.value.today ?? HoroscopeDateRangeData.empty
        }
        
        self.horoscopeSelectedPeriodData.accept(periodData)
    }
}
