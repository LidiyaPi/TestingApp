//
//  BasketTableViewCell.swift
//  TestingApp
//
//  Created by Лидия Пятаева on 05.07.2023.
//

import UIKit
import SnapKit

class BasketTableViewCell: UITableViewCell {
    
    private var dish: Dishes?
    
    var minusButtonAction: (() -> Void)?
    var plusButtonAction: (() -> Void)?
    
    var quantity: Int = 0 {
        didSet {
                   if quantity < 0 {
                       quantity = 0
                   }
            quantityLabel.text = "\(quantity)"
        }
    }
    
    
    private var dishImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "пекарни_и_кондитерские")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    private let dishName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "SF Pro Display", size: 14)
        label.text = "Title"
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "SF Pro Display", size: 14)
        label.text = "price"
        return label
    }()
    
    private let quantityControl: UIControl = {
        let control = UIControl()
        control.backgroundColor = UIColor(red: 239/255, green: 238/255, blue: 236/255, alpha: 1)
        control.layer.cornerRadius = 10
        return control
    }()
    
    let minusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 10
        button.setTitle(" - ", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(minusButtonTapped), for: .touchDown)
        button.layer.borderWidth = 0.0
        button.alpha = 1
        return button
    }()
    
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "SF Pro Display", size: 14)
        label.text = "0"
        label.textColor = .black
        return label
    }()
    
    let plusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 10
        button.setTitle(" + ", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchDown)
        button.layer.borderWidth = 0.0
        button.alpha = 1
        return button
    }()
    
    private func customizeCell() {
        backgroundColor = .white
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI() {
        addSubviews()
        setupConstraints()
        customizeCell()
        selectionStyle = .none
    }
    
    private func addSubviews() {
        contentView.addSubview(dishImage)
        contentView.addSubview(dishName)
        contentView.addSubview(priceLabel)
        contentView.addSubview(quantityControl)
        quantityControl.addSubview(minusButton)
        quantityControl.addSubview(quantityLabel)
        quantityControl.addSubview(plusButton)
    }
    
    private func setupConstraints() {
        
        dishImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(16)
            make.height.width.equalTo(62)
        }
        
        dishName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalTo(dishImage.snp.right).offset(16)
//            make.right.equalTo(minusButton.snp.left)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(dishName.snp.bottom)
            make.left.equalTo(dishImage.snp.right).offset(16)
         
        }
        
        quantityControl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.right.equalToSuperview().offset(-16)
            make.width.equalTo(100)
            make.height.equalTo(32)
        }
        
        minusButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(quantityLabel.snp.left).inset(-8)
        }
        
        quantityLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        plusButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(quantityLabel.snp.right).inset(-8)
        }
    }
    
    func setup(model: BasketDishes) {
        dish = model.dish
        quantity = model.quantity
        dishName.text = model.dish.name
        priceLabel.text = String(model.dish.price)
        quantityLabel.text = String(model.quantity)

        guard let url = URL(string: model.dish.imageUrl ) else { return }
        dishImage.sd_setImage(with: url)

    }
    
    @objc private func minusButtonTapped() {
        minusButtonAction?()
    }
    
    @objc private func plusButtonTapped() {
        plusButtonAction?()
    }
    
}
