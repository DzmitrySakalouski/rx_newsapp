import UIKit
import RxCocoa
import RxSwift

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat? = 0, paddingLeft: CGFloat? = 0, paddingBottom: CGFloat? = 0, paddingRight: CGFloat? = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
    
    translatesAutoresizingMaskIntoConstraints = false // turns on programmatic constrains
    
    if let top = top {
        topAnchor.constraint(equalTo: top, constant: paddingTop!).isActive = true
    }
    
    if let left = left {
        leftAnchor.constraint(equalTo: left, constant: paddingLeft!).isActive = true
    }
    
    if let bottom = bottom {
        if let paddingBottom = paddingBottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
    }
    
    if let right = right {
        if let paddingRight = paddingRight {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
    }
    
    if let width = width {
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    if let height = height {
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}
}

struct Resource<T: Decodable> {
    let url: URL
}

extension URLRequest {
    static func load<T>(resource: Resource<T>) -> Observable<T?> {
        return Observable.from([resource.url])
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
        }.map { data -> T? in
            return try? JSONDecoder().decode(T.self, from: data)
        }.asObservable()
    }
}
