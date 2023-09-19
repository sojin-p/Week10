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
        
//        PunkNetwork.shared.randomBeer()
//        PunkNetwork.shared.getBeers()
        PunkNetwork.shared.getSingleBeer()
    }

}

// MARK: - Beer

typealias Beer = [BeerElement]

struct BeerElement: Decodable {
    let id: Int
    let name, tagline, description: String
    let image_url: String
}
