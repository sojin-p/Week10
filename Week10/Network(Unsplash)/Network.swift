//
//  Network.swift
//  Week10
//
//  Created by 박소진 on 2023/09/19.
//

import Foundation
import Alamofire

class Network {
    
    static let shared = Network()
    
    private init() { }
    
    func requestConvertible<T: Decodable>(type: T.Type, api: Router, comletion: @escaping (Result<T, SeSACError>) -> Void ) {
        
        //AF.request(api.endpoint, method: api.method, parameters: api.query, encoding: URLEncoding(destination: .queryString), headers: api.header) 줄어들었다.
        AF.request(api).responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data): comletion(.success(data))
                case .failure(_):
                    let statusCode = response.response?.statusCode ?? 500
                    guard let error = SeSACError(rawValue: statusCode) else { return }
                    comletion(.failure(error))
                }
            }
        
    }
    
    //제네릭으로 만들기 <T>
    //디코딩이 가능해야 하기 때문에, 디코더블 프로토콜을 채택하고 있는 제약조건을 설정하기 <T: Decodable>
    //VC에서 불러왔더니 타입 구체적으로 써달라고 에러가 뜬다. 그래서 type: T.Type (구조체 그 자체를 가지고 오겠다)
//    func callRequest<T: Decodable>(type: T.Type, api: UnsplashAPI, comletion: @escaping (Result<T, SeSACError>) -> Void ) {
//
//        AF.request(api.endpoint, method: api.method, parameters: api.query, encoding: URLEncoding(destination: .queryString), headers: api.header)
//            .responseDecodable(of: T.self) { response in
//                switch response.result {
//                case .success(let data): comletion(.success(data))
//                case .failure(_):
//                    let statusCode = response.response?.statusCode ?? 500 //상태 코드가 nil일 경우를 대비한다.
//                    guard let error = SeSACError(rawValue: statusCode) else { return }
//                    comletion(.failure(error)) //열거형 에러 던지기
//                }
//            }
//
//    }
}
