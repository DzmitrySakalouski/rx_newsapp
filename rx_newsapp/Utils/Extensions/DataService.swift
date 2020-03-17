
import RxSwift
import RxCocoa
import Foundation

struct Resource<T> where T:Decodable, T:Encodable {
    let url: URL
    let method: String
    let data: T?
}

extension URLRequest {
    static func load<T>(resource: Resource<T>) -> Observable<T> {
        print("ANSWER1111")
        return Observable.just(resource.url)
            .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
                var request = URLRequest(url: url)
                
                if resource.data != nil {
                    let jsonPayload = try JSONEncoder().encode(resource.data)
                    request.httpBody = jsonPayload
                }
                
                request.httpMethod = resource.method
                
                return URLSession.shared.rx.response(request: request)
        }.map { response, data -> T in
            
            if 200..<300 ~= response.statusCode {
                return try JSONDecoder().decode(T.self, from: data)
            } else {
                throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
            }
        }.asObservable()
    }
    
    static func post<T>(resource: Resource<T>) -> Observable<Data> {
        return Observable.just(resource.url)
            .flatMap { url -> Observable<Data> in
            var request = URLRequest(url: url)
                       
            if resource.data != nil {
                let jsonPayload = try JSONEncoder().encode(resource.data)
                request.httpBody = jsonPayload
            }
                       
            request.httpMethod = "POST"
                       
            return URLSession.shared.rx.data(request: request)
            }.map { data in
                   print(data)
                return data
               }.asObservable()
    }
}
