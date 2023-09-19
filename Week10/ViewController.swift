//
//  ViewController.swift
//  Week10
//
//  Created by 박소진 on 2023/09/19.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func callRequest() {
        
        let url = URL(string: "https://api.unsplash.com/search/photos?query=sky&client_id=\(key)")
        
        AF.request(url, method: .get).validate()
            .responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }


}

