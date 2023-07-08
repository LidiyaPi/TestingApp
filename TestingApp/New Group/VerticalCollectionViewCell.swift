//
//  SecondCollectionViewCell.swift
//  CollectionView20.04
//
//  Created by Ivan on 20.04.2022.
//

import UIKit

class VerticalCollectionViewCell: UICollectionViewCell {
    
    private var dishImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "пекарни_и_кондитерские")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let dishTitleLabel: UILabel = {
        let label: UILabel = .init()
        label.font = UIFont(name: "SF Pro Display", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Dish name"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(dishImage)
        contentView.addSubview(dishTitleLabel)
    }
    
    private func addConstraints() {
        
        dishImage.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.height.width.equalTo(110)
        }
        
        dishTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(dishImage.snp.bottom)
            make.left.right.equalToSuperview().inset(8)
        }
    }
    
    func setup(model: Dishes) {
       
        dishTitleLabel.text = model.name
        
        guard let url = URL(string: model.imageUrl ) else { return }
        dishImage.sd_setImage(with: url)
     
    }
    
   
}
