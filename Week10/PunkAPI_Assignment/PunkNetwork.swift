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
        
        guard let url = URL(string: "https://api.punkapi.com/v2/beers") else { return }
        
        AF.request(url, method: .get).responseDecodable(of: Beer.self) { response in
                switch response.result {
                case .success(let data): dump(data)
                case .failure(let error): print(error)
                }
            }
    }
}
