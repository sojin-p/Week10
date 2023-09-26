//
//  SearchViewController.swift
//  Week10
//
//  Created by 박소진 on 2023/09/21.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {

    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    //디퍼블은 클래스기준
    var dataSource: UICollectionViewDiffableDataSource<Int, Int>! //선언. 초기화는 펑션으로!

    let list = Array(0...100)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        configureHierarchy()
        configureLayout()
        configureDataSource()

    }

    func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    func configureLayout() {
        collectionView.backgroundColor = .orange
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    //2.
    func configureDataSource() {
        
        //4.
        let cellRegistration = UICollectionView.CellRegistration<SearchCell, Int> { cell, indexPath, itemIdentifier in
            cell.imageView.image = UIImage(systemName: "star.fill")
            cell.label.text = "\(itemIdentifier)번"
        }
    
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            //3.
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0]) //섹션 몇 개, 그 섹션의 이름이 뭐야?
        snapshot.appendItems(list) //어떤 데이터를 넣을거야?
        dataSource.apply(snapshot) //갱신
        
    }
    
    func layout() -> UICollectionViewLayout { //플로우 레이아웃, 컴포지셔널 레이아웃이 UICollectionViewLayout를 갖고있다.
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4), //4분의 1 사이즈로 넣을거라
                                              heightDimension: .fractionalHeight(1.0)) //0~1사이의 값 1.0은 꽉 차게. 즉, 그룹이 80이라서 그룹에 꽉차게 들어가서 80으로 잡힌다.
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), //fractional: 컬렉션 뷰 크기에 상대적인 비율, 1.0 -> 꽉 차게!
                                               heightDimension: .absolute(80)) //absolute: 리터럴한 값
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       repeatingSubitem: item,
                                                       count: 4) //horizontal: 수평으로 Item이 붙는 것 / 컬렉션뷰 스크롤과는 관계없음
        group.interItemSpacing = .fixed(10) //사이사이 inset
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10) //inset
        section.interGroupSpacing = 20 //섹션마다 inset
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal //컬렉션 뷰를 수평 스크롤로 바꾸기
        layout.configuration = configuration
        
        return layout
    }

//    func layout() -> UICollectionViewLayout {
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 50, height: 50)
//        layout.scrollDirection = .vertical
//        return layout
//    }

}

//------------------------------------------------------------------------
//class SearchViewController: UIViewController, UIScrollViewDelegate {
//
//    let scrollView = UIScrollView()
//    let contentView = UIView() //커스텀뷰로 빼는 것 권장
//
//    let imageView = UIImageView()
//    let label = UILabel()
//    let button = UIButton()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .white
//
//        configureHierarchy()
//        configureLayout()
//        configureContentView()
//
//    }
//
//    func configureContentView() {
//        contentView.addSubview(imageView)
//        contentView.addSubview(button)
//        contentView.addSubview(label)
//
//        imageView.backgroundColor = .orange
//        button.backgroundColor = .magenta
//        label.backgroundColor = .systemMint
//
//        imageView.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(contentView).inset(10)
//            make.height.equalTo(200)
//        }
//
//        button.snp.makeConstraints { make in
//            make.bottom.horizontalEdges.equalTo(contentView).inset(10)
//            make.height.equalTo(80)
//        }
//
//        label.text = "????\n????????\n?????????\n???????asf\nasgasgasfasfasfdag\nfdsdmfnksnfkasnf????\n????????\n?????????\n???????asf\nasgasgasfasfasfdag\nfdsdmfnksnfkasnf????\n????????\n?????????\n???????asf\nasgasgasfasfasfdag\nfdsdmfnksnfkasnf????\n????????\n?????????\n???????asf\nasgasgasfasfasfdag\nfdsdmfnksnfkasnf????\n????????\n?????????\n???????asf\nasgasgasfasfasfdag\nfdsdmfnksnfkasnf????\n????????\n?????????\n???????asf\nasgasgasfasfasfdag\nfdsdmfnksnfkasnf"
//        label.numberOfLines = 0
//        label.snp.makeConstraints { make in
//            make.horizontalEdges.equalTo(contentView).inset(10)
//            make.top.equalTo(imageView.snp.bottom).offset(50)
//            make.bottom.equalTo(button.snp.top).offset(-50)
//        }
//    }
//
//    func configureHierarchy() {
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//    }
//
//    func configureLayout() {
//        scrollView.backgroundColor = .lightGray
//        scrollView.bounces = false
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
//
//        }
//
//        contentView.backgroundColor = .white
//        contentView.snp.makeConstraints { make in
//            make.edges.equalTo(scrollView)
//            make.width.equalTo(scrollView.snp.width)
//        }
//    }
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset)
//        print(scrollView.contentOffset.y)
//
//        if scrollView.contentOffset.y >= 50 {
//            label.alpha = 0
//        }
//    }
//} //------------------------------------------------------------------------

//class SearchViewController: UIViewController {
//
//    let scrollView = UIScrollView()
//    let stackView = UIStackView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .white
//
//        configureHierarchy()
//        configureLayout()
//        configureStackView()
//
//    }
//
//    func configureHierarchy() {
//        view.addSubview(scrollView)
//        scrollView.addSubview(stackView)
//    }
//
//    func configureLayout() {
//
//        scrollView.backgroundColor = .magenta
//        scrollView.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
//            make.height.equalTo(70)
//        }
//
//        stackView.spacing = 16
//        stackView.backgroundColor = .blue
//        stackView.snp.makeConstraints { make in
//            make.edges.equalTo(scrollView)
//            make.height.equalTo(scrollView)
//        }
//
//
//    }
//
//    func configureStackView() {
//        let label1 = UILabel()
//        label1.backgroundColor = .darkGray
//        label1.text = "Hadfasfadafdasfdagsgdi"
//        label1.textColor = .white
//        stackView.addArrangedSubview(label1)
//
//        let label2 = UILabel()
//        label2.backgroundColor = .orange
//        label2.text = "Hell@@@@@@@@@@@@@@@@@@o"
//        label2.textColor = .white
//        stackView.addArrangedSubview(label2)
//
//        let label3 = UILabel()
//        label3.text = "what~~~~~~~~~~~~~~~~~~"
//        label3.textColor = .white
//        stackView.addArrangedSubview(label3)
//
//        let label4 = UILabel()
//        label4.text = "hahaha"
//        label4.textColor = .white
//        stackView.addArrangedSubview(label4)
//
//        let label5 = UILabel()
//        label5.text = "holymoly"
//        label5.textColor = .white
//        stackView.addArrangedSubview(label5)
//    }
//}
