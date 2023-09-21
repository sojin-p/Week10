//
//  BeersCell.swift
//  Week10
//
//  Created by 박소진 on 2023/09/20.
//

import UIKit
import SnapKit

class BeersCell: UICollectionViewCell {
    
    let nameLabel = UILabel()
    let imageView = UIImageView()
    let tagLineLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        [nameLabel, imageView, tagLineLabel, descriptionLabel].forEach { contentView.addSubview($0) }
    }
    
    func setConstraints() {
        
        nameLabel.numberOfLines = 2
        nameLabel.textAlignment = .center
        nameLabel.font = .boldSystemFont(ofSize: 17)
        nameLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(40)
        }
        
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(contentView.snp.width).multipliedBy(1.3)
        }
        
        tagLineLabel.numberOfLines = 2
        tagLineLabel.font = .systemFont(ofSize: 14)
        tagLineLabel.text = "namename"
        tagLineLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(50)
        }
        
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(tagLineLabel.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(contentView)
        }
    }
    
}
