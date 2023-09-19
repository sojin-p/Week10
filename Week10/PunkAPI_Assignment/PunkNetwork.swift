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
    
    func getBeers() {
        
        let api = PunkAPI.beers
        
        AF.request(api.endpoint, method: api.method).responseDecodable(of: Beer.self) { response in
            switch response.result {
            case .success(let data): dump(data)
            case .failure(let error): print(error)
            }
        }
    }
    
    func getSingleBeer() {
        
        let api = PunkAPI.singleBeer
        
        AF.request(api.endpoint, method: api.method).responseDecodable(of: Beer.self) { response in
            switch response.result {
            case .success(let data): dump(data)
            case .failure(let error): print(error)
            }
        }
    }
    
    func randomBeer() {
        
        let api = PunkAPI.randomBeer
        
        AF.request(api.endpoint, method: api.method).responseDecodable(of: Beer.self) { response in
            switch response.result {
            case .success(let data): dump(data)
            case .failure(let error): print(error)
            }
        }
    }
}
