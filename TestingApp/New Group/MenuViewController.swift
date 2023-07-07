//
//  MenuViewController.swift
//  TestingApp
//
//  Created by Лидия Пятаева on 03.07.2023.
//

import UIKit
import SnapKit

class MenuViewController: UIViewController {
    
    private var dishes = [String: [Any]]()
    private let horizontalCV = HorizontalCollectionViewCell()
    private let verticalCV = VerticalCollectionViewCell()
    private var selectedTag: IndexPath?
    
    func buttonPressed(number: Int) {
        print("j")
    }
    
    private var tegs = [Tegs]()
    
    
    private var horizontalArray: [Int] {
        var array = [Int]()
        for element in 0...6 {
            array.append(element)
        }
        return array
    }
    
    private lazy var horizontalCollection = makeCollectionView(scrollDirection: .horizontal)
    private lazy var verticalCollection = makeCollectionView(scrollDirection: .vertical)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationController()
        addSubviews()
        addConstraints()
        setupCollections()
        print(dishes)
    }
    
    private func setupNavigationController() {
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        containerView.layer.cornerRadius = 25
        containerView.clipsToBounds = true
        
        let button = UIBarButtonItem(customView: containerView)
        navigationItem.rightBarButtonItem = button
        
        let imageView = UIImageView(frame: containerView.bounds)
        imageView.image = UIImage(named: "Profile")
        imageView.contentMode = .scaleAspectFill
        containerView.addSubview(imageView)
        
        let attributes = [NSAttributedString.Key.font:UIFont(name: "HelveticaNeue", size: 22)]
        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key: Any]
        navigationItem.title = "Азиатская кухня"
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func setupCollections() {
        horizontalCollection.dataSource = self
        horizontalCollection.delegate = self
        horizontalCollection.register(HorizontalCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        
        verticalCollection.dataSource = self
        verticalCollection.delegate = self
        verticalCollection.register(VerticalCollectionViewCell.self, forCellWithReuseIdentifier: "SecondCollectionViewCell")
    }
    
    private func addSubviews() {
        view.addSubview(horizontalCollection)
        view.addSubview(verticalCollection)
    }
    
    private func addConstraints() {
        horizontalCollection.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(4)
            make.left.equalToSuperview().inset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(50)
        }
        verticalCollection.snp.makeConstraints { make in
            make.top.equalTo(horizontalCollection.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(600)
        }
    }
    
    func setup(model: [String: [Any]]) {
        dishes = model
//        horizontalCV.tagLabel = model
        
    }
    

}


// MARK: - UICollectionViewDataSource

extension MenuViewController: UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        array.count
//
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case verticalCollection:
            return dishes.count
        case horizontalCollection:
            var tagDishes: Int = 0
//            dishes = dishes.sorted { $0.value. < $1.key}
            if selectedTag == nil {
                tagDishes = dishes.values.first?.count ?? 0

            }
            return tagDishes
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case horizontalCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! HorizontalCollectionViewCell
            cell.backgroundColor = .systemGray4
            var tegs = dishes.keys
            var onlyTegs = [String]()

            for tag in dishes.keys {
                onlyTegs.append(tag)
            }
            cell.setup(title: onlyTegs[indexPath.row])
            return cell
        case verticalCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondCollectionViewCell", for: indexPath) as! VerticalCollectionViewCell
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat { return 10 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case horizontalCollection:
        
//                let width = (collectionView.bounds.width - sideInset * 8) / 2
                return CGSize(width: 86, height: 35)
        case verticalCollection:
            let height = (collectionView.bounds.height - sideInset * 3) / 2
            return CGSize(width: 109, height: 109)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case horizontalCollection:
           return UIEdgeInsets(top: 0, left: sideInset, bottom: 0, right: 100)
        case verticalCollection:
           return UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case horizontalCollection: break
           
        case verticalCollection:
                    let destination = ProductViewController()
                    destination.transitioningDelegate = transitioningDelegate
                    destination.modalPresentationStyle = .custom
                    present(destination, animated: true)

        default:
            break
        }
        print(indexPath.section, indexPath.item)
    }
}

extension UIViewController {
    func makeCollectionView(scrollDirection: UICollectionView.ScrollDirection) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white

//        collection.register(HorizontalCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalCollectionViewCell.identifier)
        return collection
    }
}