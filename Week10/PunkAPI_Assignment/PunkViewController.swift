//
//  PunkViewController.swift
//  Week10
//
//  Created by 박소진 on 2023/09/19.
//

import UIKit

class PunkViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        PunkNetwork.shared.getBeers(type: Beer.self, api: .randomBeer)
//        PunkNetwork.shared.getBeers(type: Beer.self, api: .beers)
        PunkNetwork.shared.getBeers(type: Beer.self, api: .singleBeer)
    }

}

// MARK: - Beer

typealias Beer = [BeerElement]

struct BeerElement: Decodable {
    let id: Int
    let name, tagline, description: String
    let image_url: String
}
