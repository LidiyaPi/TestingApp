//
//  CategoryCell.swift
//  TestingApp
//
//  Created by Лидия Пятаева on 02.07.2023.
//

import UIKit
import SnapKit
import SDWebImage

class CategoryCell: UITableViewCell {
    
    private var imageShop: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "пекарни_и_кондитерские")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let couponName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "SF Pro Display", size: 25)
        label.text = "title"
        return label
    }()
    
    private func customizeCell() {
//        whiteView.layer.cornerRadius = 10
//        whiteView.layer.borderWidth = 2
        backgroundColor = .white
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
    
    private func setupUI() {
        addSubviews()
        setupConstraints()
        customizeCell()
        selectionStyle = .none
    }
    
    private func addSubviews() {
        contentView.addSubview(imageShop)
        contentView.addSubview(couponName)
    }
    
    private func setupConstraints() {
        
        imageShop.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview().inset(5)
        }
        
        couponName.snp.makeConstraints { make in
            make.top.equalTo(imageShop.snp.top).inset(8)
            make.left.equalTo(imageShop.snp.left).offset(16)
            make.right.equalTo(imageShop.snp.right)
        }
    }
    
//    func setupData( viewModel: Categories) {
//        couponName.text = viewModel.name
//        guard let url = URL(string: viewModel.image_url ?? "") else { return }
//                imageShop.sd_setImage(with: url)
        
    func setupCell(_ model: ArrayCategories ) {
            let categories = model.name
            
           print("categories")
            couponName.text = model.name

        guard let url = URL(string: model.imageUrl) else { return }
            imageShop.sd_setImage(with: url)
        }

    }

