//
//  NetworkBasic.swift
//  Week10
//
//  Created by 박소진 on 2023/09/19.
//

import Foundation
import Alamofire

//1.
//상태코드가 바뀔 수도 있어서 리터럴한 숫자보단 열거형을 사용하여 유연하게 대응
//혹은 케이스가 더 생긴다거나
enum SeSACError: Int, Error, LocalizedError { //LocalizedError: 하나의 국가만 대응하는 게 아닐 때!
    case unathorized = 401
    case permisstionDenied = 403
    case invalidServer = 500
    case missingParameter = 400
    
    var errorDescription: String {
        switch self {
        case .unathorized:
            return "인증 정보가 없습니다."
        case .permisstionDenied:
            return "권한이 없습니다."
        case .invalidServer:
            return "서버 점검 중입니다."
        case .missingParameter:
            return "검색어를 입력해주세요."
        }
    }
    
}

final class NetworkBasic { //final: 상속할 필요가 없으니까, 이것을 수정해도 되겠다(다른 파일에 영향을 끼치지 않을테니)
    
    static let shared = NetworkBasic()
    private init() { }
    
    func callRequest(api: UnsplashAPI, query: String, comletion: @escaping (Result<Photo, SeSACError>) -> Void ) { // search photo
        
        AF.request(api.endpoint, method: api.method, parameters: api.query, encoding: URLEncoding(destination: .queryString), headers: api.header)
            .responseDecodable(of: Photo.self) { response in
                switch response.result {
                case .success(let data): comletion(.success(data))
                case .failure(_):
                    let statusCode = response.response?.statusCode ?? 500 //상태 코드가 nil일 경우를 대비한다.
                    guard let error = SeSACError(rawValue: statusCode) else { return }
                    comletion(.failure(error)) //열거형 에러 던지기
                }
            }
        
    } // search Photo
    
    func randomRequest(api: UnsplashAPI, completion: @escaping (Result<PhotoResult, SeSACError>) -> Void ) {
         
        AF.request(api.endpoint, method: api.method, headers: api.header)
            .responseDecodable(of: PhotoResult.self) { response in
                switch response.result {
                case .success(let data): completion(.success(data))
                case .failure(_):
                    let statusCode = response.response?.statusCode ?? 500
                    guard let error = SeSACError(rawValue: statusCode) else { return }
                    completion(.failure(error))
                }
            }
        
    } //random
    
    func detailPhotoRequest(id: String, api: UnsplashAPI, completion: @escaping (Result<PhotoResult, SeSACError>) -> Void ) { //QbF0TVjCqXs
        
        AF.request(api.endpoint, method: api.method, headers: api.header)
            .responseDecodable(of: PhotoResult.self) { response in
                switch response.result {
                case .success(let data): completion(.success(data))
                case .failure(_):
                    let statusCode = response.response?.statusCode ?? 500
                    guard let error = SeSACError(rawValue: statusCode) else { return }
                    completion(.failure(error))
                }
            }
        
    } //random //QbF0TVjCqXs
}
