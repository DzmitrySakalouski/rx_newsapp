import UIKit
import Foundation
import RxSwift
import RxCocoa

extension CompatibilityViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        let sign = zodiacSignsArray[indexPath.row]
        let selectedSignsArr = self.compatibilityVM.selectedSignsForComatibility.value
        
        if selectedSignsArr.count >= 2 {
            print("Hello")
            return
        } else {
            var newSigns = selectedSignsArr
            
            newSigns.append(sign)
            
            self.compatibilityVM.selectedSignsForComatibility.accept(newSigns)
        }
    }
}
