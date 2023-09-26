//
//  Constant.swift
//  Week10
//
//  Created by 박소진 on 2023/09/22.
//

import UIKit

enum Constant {
    
    enum Text {
        static let title = UIColor(named: "title")! //에셋 이름을 넣으면 됨 다크면 바로 적용
    }
    
    enum Image {
        static let star = UIImage(systemName: "star")!.withRenderingMode(.alwaysOriginal).withTintColor(Constant.Text.title)
    }
}
