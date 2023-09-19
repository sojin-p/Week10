//
//  PunkNetwork.swift
//  Week10
//
//  Created by 박소진 on 2023/09/19.
//

import Foundation
import Alamofire

enum PunkError: Int, Error {
    case unathorized = 401
    case permisstionDenied = 403
    case invalidServer = 500
    case missingParameter = 400
    
    var errorMessage: String {
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

class PunkNetwork {
    
    static let shared = PunkNetwork()
    private init() { }
    
    func getBeers<T: Decodable>(type: T.Type, api: PunkAPI, completion: @escaping (Result<T, PunkError>) -> Void ) {
        
        AF.request(api.endpoint, method: api.method).validate(statusCode: 200...500)
            .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data): completion(.success(data))
            case .failure(_):
                let statusCode = response.response?.statusCode ?? 500
                guard let error = PunkError(rawValue: statusCode) else { return }
                completion(.failure(error))
            }
        }
    }
}
