//
//  UnsplashAPI.swift
//  Week10
//
//  Created by 박소진 on 2023/09/19.
//

import Foundation
import Alamofire

enum UnsplashAPI { //URLRequestConvertible 구조 강제화.
    
    static let key = APIKey.unsplashKey
    
    case search(query: String) //두 가지 받고 싶으면 쉼표 찍고 쓰면 됨
    case random
    case detailPhoto(id: String) //연관값, associated value 어쏘시에이트 밸류
    
    var baseURL: String {
        return "https://api.unsplash.com/" //베이스 URL이 여러 개일 수 있는데 그 땐 스위치 구문으로 대응
//        switch self {
//        case .search, .random: //이렇게는 베이스가 똑같고, 저 밑은 다르고 이럴 수 있음
//            <#code#>
//        case .detailPhoto:
//            <#code#>
//        }
    }
    
    var endpoint: URL {
        switch self {
        case .search:
            return URL(string: baseURL + "search/photos")!
        case .random:
            return URL(string: baseURL + "photos/random")!
        case .detailPhoto(let id):
            return URL(string: baseURL + "photos/\(id)")!
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": "Client-ID \(APIKey.unsplashKey)"]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var query: [String: String] { //나중에는 옵셔널로..
        switch self {
        case .search(let query):
            return ["query": query] //Get Query에는 제약이 있다(범주가 좁다). 자릿 수 등 - 강의자료 참고
        case .random, .detailPhoto: //(let id) 연관 값은 여기서 안 쓸거라 지워도 됨
            return ["": ""]
        }
    }
    
}
