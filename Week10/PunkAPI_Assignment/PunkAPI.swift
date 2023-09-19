//
//  PunkAPI.swift
//  Week10
//
//  Created by 박소진 on 2023/09/19.
//

import Foundation
import Alamofire

enum PunkAPI {
    case beers
    case singleBeer
    case randomBeer
    
    private var baseURL: String {
        return "https://api.punkapi.com/v2/beers/"
    }
    
    var endpoint: URL {
        switch self {
        case .beers:
            return URL(string: baseURL)!
        case .singleBeer:
            return URL(string: baseURL + "1")!
        case .randomBeer:
            return URL(string: baseURL + "random")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
}
