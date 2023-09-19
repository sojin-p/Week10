//
//  PunkNetwork.swift
//  Week10
//
//  Created by 박소진 on 2023/09/19.
//

import Foundation
import Alamofire

class PunkNetwork {
    
    static let shared = PunkNetwork()
    private init() { }
    
    func getBeers<T: Decodable>(type: T.Type, api: PunkAPI) {
        
        AF.request(api.endpoint, method: api.method).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data): dump(data)
            case .failure(let error): print(error)
            }
        }
    }
}
