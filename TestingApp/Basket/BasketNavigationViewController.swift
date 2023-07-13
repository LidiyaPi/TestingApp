//
//  BasketNavigationViewController.swift
//  TestingApp
//
//  Created by Лидия Пятаева on 13.07.2023.
//

import UIKit

class BasketNavigationViewController: UIView {
    
    
    let containerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view.backgroundColor = .white
        view.layer.cornerRadius = view.frame.width / 2
        view.clipsToBounds = true
        return view
    }()
    
    private var positionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "position")
        imageView.frame.size = CGSize(width: 50, height: 50)
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    private let cityLabel: UILabel = {
        let label: UILabel = .init()
        label.font = UIFont(name: "SF Pro Display", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "Уфа"
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label: UILabel = .init()
        label.font = UIFont(name: "SF Pro Display", size: 18)
        //        label.alpha = 0.4
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "Date"
        return label
    }()
    
    private var profileImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        imageView.image = UIImage(named: "Profile")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.width / 2
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addSubviews()
        addConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(positionImage)
        addSubview(cityLabel)
        addSubview(dateLabel)
        addSubview(profileImage)
    }
    
    private func addConstraints() {
        
        positionImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(16)
            make.height.width.equalTo(40)
        }
        
        cityLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(1)
            make.left.equalTo(positionImage.snp.right).offset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(1.5)
            make.left.equalTo(positionImage.snp.right).offset(10)
        }
        
        profileImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview().inset(16)
            make.size.equalTo(44)
        }
    }
    private func setupUI() {
        dateLabel.text = curentDate()
    }
    
    private func curentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        
        let currentDate = Date()
        
        let formattedDate = dateFormatter.string(from: currentDate)
        
        return formattedDate
    }
    
    
}
