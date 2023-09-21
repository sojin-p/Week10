//
//  SearchCell.swift
//  Week10
//
//  Created by 박소진 on 2023/09/21.
//

import UIKit
import SnapKit

class SearchCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
        imageView.backgroundColor = .lightGray
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        label.text = "Test"
        label.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }

    }
}
