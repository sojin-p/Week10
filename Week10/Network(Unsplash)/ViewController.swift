//
//  ViewController.swift
//  Week10
//
//  Created by 박소진 on 2023/09/19.
//

import UIKit
import Kingfisher
import SnapKit

class ViewController: UIViewController {
    
    private lazy var scrollView = {
        let view = UIScrollView()
        view.backgroundColor = .cyan
        view.minimumZoomScale = 1
        view.maximumZoomScale = 3 //보통 3~5
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        return view
    }()
    
    private let imageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true //제스처 받기
        return view
    }()
    
    let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureHierarchy()
        configureLayout()
        configureGesture()
        
        viewModel.request { url in
            self.imageView.kf.setImage(with: url)
        }
        
    }
    
    private func configureGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapGesture))
        tap.numberOfTapsRequired = 2 //몇번의 탭을 요구할건지
        imageView.addGestureRecognizer(tap)
    }
    
    @objc private func doubleTapGesture() {
        if scrollView.zoomScale == 1 {
            scrollView.setZoomScale(2, animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }
    
    private func configureLayout() {
        
        scrollView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.size.equalTo(250)
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(scrollView)
        }
    }
    
    private func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
    }

}

extension ViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? { //줌하면 어떻게 할까?
        return imageView //이미지뷰 넣어주면 돼
    }
    
}

//Codable = 디코더블 인코더블 같이 갖고 있는 것 (인코더블은 우리가 만든 것을 외부로 보내는 거라 디코더블만 채택)
struct Photo: Decodable, Hashable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Decodable, Hashable {
    let id: String
    let created_at: String
    let urls: PhotoURL
    let width: CGFloat
    let height: CGFloat
}

struct PhotoURL: Decodable, Hashable {
    let full: String
    let thumb: String
}







