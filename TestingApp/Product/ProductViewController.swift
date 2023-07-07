//
//  ProductViewController.swift
//  TestingApp
//
//  Created by Лидия Пятаева on 06.07.2023.
//


import UIKit

struct PopUpWarningPINViewModel {
    let title: String
    let description: String?
}

//protocol PopUpWarningViewControllerHandler: AnyObject {
//
//    /// Метод срабатывающий при нажатии кнопки "Закрыть"
//    func didTapCloseButton()
//}

final class ProductViewController: UIViewController {
    
    private var autoPayIsEnable: Bool = false
    
    // MARK: Views
    
    private let opacityView: UIView = {
        let view: UIView = .init()
        view.backgroundColor = .gray
        view.alpha = 0.4

        return view
    }()
    
    private let wrapper: UIView = {
        let view: UIView = .init()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
//        view.layer.shadowColor = .init(gray: 08, alpha: 0.8)
        return view
    }()
    
    private var productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "пекарни_и_кондитерские")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    private var addLikeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.tintColor = .black
//        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.setTitle("Д", for: .normal)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.font = UIFont(name: "SF Pro Display", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "Product name"
        return label
    }()
    
    private let priceWeightLabel: UILabel = {
        let label: UILabel = .init()
        label.font = UIFont(name: "SF Pro Display", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "Product name"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label: UILabel = .init()
        label.font =  UIFont(name: "SF Pro Display", size: 14)
        label.textColor = .darkGray
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "Product description"
        if #available(iOS 14.0, *) {
            label.lineBreakStrategy = []
        }
        return label
    }()
    
    private var addToBasketButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(red: 51/255, green: 100/255, blue: 224/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.setTitle("Добавить в корзину", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
        func setup(
        title: String,
        description: String
    ) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
        private func setupUI() {
            addSubviews()
            addConstraints()
            addAction()
        }
        
        private func addSubviews() {
            view.addSubview(opacityView)
            view.addSubview(wrapper)
            wrapper.addSubview(productImage)
            productImage.addSubview(addLikeButton)
            productImage.addSubview(closeButton)
            wrapper.addSubview(titleLabel)
            wrapper.addSubview(priceWeightLabel)
            wrapper.addSubview(descriptionLabel)
            wrapper.addSubview(addToBasketButton)
        }
        
        private func addConstraints() {
            opacityView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            wrapper.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.left.right.equalToSuperview().inset(16)
                make.top.greaterThanOrEqualToSuperview().offset(16)
                make.bottom.lessThanOrEqualToSuperview().inset(16)
            }
            
            productImage.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(24)
                make.horizontalEdges.equalToSuperview().inset(24)
                make.height.equalTo(204)
            }
            
            addLikeButton.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(8)
                make.right.equalTo(closeButton.snp.left).inset(-10)
                make.height.width.equalTo(40)
            }
            
            closeButton.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(8)
                make.right.equalToSuperview().offset(-8)
                make.height.width.equalTo(40)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalTo(productImage.snp.bottom).offset(8)
                make.left.equalToSuperview().inset(24)
                make.height.equalTo(26)
            }
            
            priceWeightLabel.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(8)
                make.left.equalToSuperview().inset(24)
                make.height.equalTo(26)
            }
            
            descriptionLabel.snp.makeConstraints { make in
                make.top.equalTo(priceWeightLabel.snp.bottom).offset(24)
                make.left.right.equalToSuperview().inset(24)
            }
            
            addToBasketButton.snp.makeConstraints { make in
                make.height.equalTo(48)
                make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
                make.left.bottom.right.equalToSuperview().inset(24)
            }
        }
    
    private func addAction() {
        let goBack = UITapGestureRecognizer(target: self, action: #selector(closeVC))
        addToBasketButton.addGestureRecognizer(goBack)
        
        let goBackX = UITapGestureRecognizer(target: self, action: #selector(closeVC))
        closeButton.addGestureRecognizer(goBackX)
//        closeButton.addGestureRecognizer(goBack)
    }
    
    @objc private func closeVC() {
        dismiss(animated: true)
    }
}
