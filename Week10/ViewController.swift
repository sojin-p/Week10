//
//  ViewController.swift
//  Week10
//
//  Created by 박소진 on 2023/09/19.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NetworkBasic.shared.randomRequest { photo, error in
//            guard let photo = photo else { return }
//            guard let error = error else { return }
//        }
        
        
        NetworkBasic.shared.detailPhotoRequest(id: "QbF0TVjCqXs") { response in
            switch response {
            case .success(let success):
                print(success) //배열에 담고 테이블 뷰 갱신
            case .failure(let failure):
                print(failure) //다시 시도해주세요 얼럿, 토스트
            }
        }
        
        NetworkBasic.shared.callRequest(query: "sky") { <#Result<Photo, Error>#> in
            <#code#>
        }
    }

}

//Codable = 디코더블 인코더블 같이 갖고 있는 것 (인코더블은 우리가 만든 것을 외부로 보내는 거라 디코더블만 채택)
struct Photo: Decodable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Decodable {
    let id: String
    let created_at: String
    let urls: PhotoURL
}

struct PhotoURL: Decodable {
    let full: String
    let thumb: String
}







