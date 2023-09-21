//
//  PunkViewModel.swift
//  Week10
//
//  Created by 박소진 on 2023/09/21.
//

import Foundation

class PunkViewModel {
    
    var list: [BeerElement] = []
    
    func request(completion: @escaping () -> Void ) {
        PunkNetwork.shared.getBeers(type: Beer.self, api: .beers) { response in
            switch response {
            case .success(let success):
//                dump(success)
                self.list = success
                dump(self.list)
                completion()

            case .failure(let failure):
                print(failure.errorMessage)
            }
        }
    }
    
}
