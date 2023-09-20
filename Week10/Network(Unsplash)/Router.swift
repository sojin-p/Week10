//
//  Router.swift
//  Week10
//
//  Created by 박소진 on 2023/09/20.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible { //URLRequestConvertible 알라모파이어에서 갖고있음

//    private static let key = APIKey.unsplashKey
    
    case search(query: String)
    case random
    case detailPhoto(id: String)
    
    private var baseURL: URL { //2. URL타입으로 변경
        return URL(string: "https://api.unsplash.com/")!
    }

    //구 endpoint
    private var path: String { //1. 좀 더 기능을 분리
        switch self {
        case .search:
            return "search/photos"
        case .random:
            return "photos/random"
        case .detailPhoto(let id):
            return "photos/\(id)"
        }
    }
    
    private var header: HTTPHeaders {
        return ["Authorization": "Client-ID \(APIKey.unsplashKey)"]
    }
    
    private var method: HTTPMethod {
        return .get
    }
    
    private var query: [String: String] {
        switch self {
        case .search(let query):
            return ["query": query]
        case .random, .detailPhoto:
            return ["": ""]
        }
    }
    
    //내부에서 다 구성 후 이 메소드로 내보내기
    func asURLRequest() throws -> URLRequest { //URLRequest: 애플거
        //3.
        let url = baseURL.appendingPathComponent(path)
        
        var request = URLRequest(url: url) //endpoint에서 이렇게 수정
        
        //4.
        request.headers = header
        request.method = method
        
        //5.
        //parameters: api.query, encoding: URLEncoding(destination: .queryString) 이것을 한 줄로 합친 것
        request = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(query, into: request) //Encoded방식인지 JSON방식인지 API 문서 체크
        
        return request
    }
    
}
