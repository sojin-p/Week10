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
    
    func callRequest(query: String, comletion: @escaping (Result<Photo, Error>) -> Void ) { // search photo
        
        guard let url = URL(string: "https://api.unsplash.com/search/photos") else { return }
        let headers: HTTPHeaders = ["Authorization": "Client-ID \(APIKey.unsplashKey)"]
        let query: Parameters = ["query": query] //Get Query에는 제약이 있다(범주가 좁다). 자릿 수 등 - 강의자료 참고
        
        //Parmeters는 Body를 넣는 자리인데, url 길이 줄이려고 queryString을 넣어서 오류가 뜰 것임.
        //encoding: 그래서 여기에 쿼리스트링이라고 설정값을 바꿔줘야 한다.
        //링크를 엄청 여러개 사용하게 되면, 어떤게 바디인지 헤더인지 쿼리인지 리터럴하게 쓰면 보기 힘들어서 구조를 잡아가는 과정
        
        AF.request(url, method: .get, parameters: query, encoding: URLEncoding(destination: .queryString), headers: headers).responseDecodable(of: Photo.self) { response in
                switch response.result {
                case .success(let data): comletion(.success(data))
                case .failure(_):
                    let statusCode = response.response?.statusCode ?? 500 //상태 코드가 nil일 경우를 대비한다.
                    guard let error = SeSACError(rawValue: statusCode) else { return }
                    comletion(.failure(error)) //열거형 에러 던지기
                }
            }
        
    } // search Photo
    
    func randomRequest(completion: @escaping (Result<PhotoResult, Error>) -> Void ) {
        
        guard let url = URL(string: "https://api.unsplash.com/photos/random") else { return }
        let headers: HTTPHeaders = ["Authorization": "Client-ID \(APIKey.unsplashKey)"]
        
        AF.request(url, method: .get, headers: headers).validate()
            .responseDecodable(of: PhotoResult.self) { response in
                switch response.result {
                case .success(let data): completion(.success(data))
                case .failure(let error): completion(.failure(error))
                }
            }
        
    } //random
    
    func detailPhotoRequest(id: String, completion: @escaping (Result<PhotoResult, Error>) -> Void ) { //QbF0TVjCqXs
        
        guard let url = URL(string: "https://api.unsplash.com/photos/\(id)") else { return }
        let headers: HTTPHeaders = ["Authorization": "Client-ID \(APIKey.unsplashKey)"]
        
        AF.request(url, method: .get, headers: headers).validate()
            .responseDecodable(of: PhotoResult.self) { response in
                switch response.result {
                case .success(let data): completion(.success(data))
                case .failure(let error): completion(.failure(error))
                }
            }
        
    } //random //QbF0TVjCqXs
}
