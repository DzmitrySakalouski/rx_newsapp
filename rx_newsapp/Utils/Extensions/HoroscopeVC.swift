import UIKit
import Foundation

extension HoroscopeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        zodiacSignsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3 - 1, height: collectionView.frame.width/3 - 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZodiacCell", for: indexPath) as! ZodiacViewCell
        cell.bind(sign: zodiacSignsArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let zodiacTitleName = self.horoscopeVM.selectedSignSubject.asDriver(onErrorJustReturn: zodiacSignsArray[0])
        zodiacTitleName.map{ "\($0.displayName)" }.drive(dropdownLabel.rx.text).disposed(by: disposeBag)
        self.horoscopeVM.selectedSignSubject.onNext(zodiacSignsArray[indexPath.row])
        self.horoscopeVM.isPopupOpenSubject.accept(false)
        self.horoscopeVM.getHoroscopeData()
    }
}
