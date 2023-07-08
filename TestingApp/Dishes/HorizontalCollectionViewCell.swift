//
//  HorizontalCollectionViewCell.swift
//  CollectionView20.04
//
//  Created by Ivan on 20.04.2022.
//


import SnapKit

class HorizontalCollectionViewCell: UICollectionViewCell {
    
    let tagLabel: UILabel = {
        let label: UILabel = .init()
        label.font = UIFont(name: "SF Pro Display", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Tag"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(tagLabel)
        constraints()
        customizeCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func customizeCell() {
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = UIColor(red: 248/255, green: 247/255, blue: 245/255, alpha: 1)
    }
    
    private func constraints() {
        
        tagLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setup(title: String) {
        tagLabel.text = title
    }
}
