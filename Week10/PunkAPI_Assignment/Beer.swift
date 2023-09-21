//
//  Beer.swift
//  Week10
//
//  Created by 박소진 on 2023/09/20.
//

import Foundation

// MARK: - Beer

typealias Beer = [BeerElement]

struct BeerElement: Decodable, Hashable {
    let id: Int
    let name, tagline, description: String
    let image_url: String
}
