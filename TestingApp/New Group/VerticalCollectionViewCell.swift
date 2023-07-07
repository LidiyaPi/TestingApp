//
//  SecondCollectionViewCell.swift
//  CollectionView20.04
//
//  Created by Ivan on 20.04.2022.
//

import UIKit

class VerticalCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func customizeCell() {
        contentView.backgroundColor = .systemGray5
        contentView.layer.cornerRadius = 8
    }
}
