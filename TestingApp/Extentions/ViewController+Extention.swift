//
//  ViewController+Extention.swift
//  TestingApp
//
//  Created by Лидия Пятаева on 08.07.2023.
//

import Foundation
import UIKit

extension UIViewController {
    func setupNavigationController() {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        containerView.layer.cornerRadius = 25
        containerView.clipsToBounds = true
        
        let button = UIBarButtonItem(customView: containerView)
        navigationItem.rightBarButtonItem = button
        
        navigationItem.rightBarButtonItem = button
        
        let imageView = UIImageView(frame: containerView.bounds)
        imageView.image = UIImage(named: "Profile")
        imageView.contentMode = .scaleAspectFill
        containerView.addSubview(imageView)
        
        let containerLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        
        let titleLabel = UILabel(frame: CGRect(x: 50, y: 0, width: containerView.frame.width, height: 22))
        titleLabel.text = "Уфа"
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont(name: "SF Pro Display", size: 18)
        containerLeftView.addSubview(titleLabel)
        
        let subtitleLabel = UILabel(frame: CGRect(x: 50, y: 22, width: containerLeftView.frame.width, height: 22))
        subtitleLabel.text = curentDate()
        subtitleLabel.textAlignment = .left
        containerLeftView.addSubview(subtitleLabel)
        
        let positionImageView = UIImageView(frame: containerLeftView.bounds)
        positionImageView.frame.size = CGSize(width: 40, height: 40)
        positionImageView.image = UIImage(named: "position")
        positionImageView.contentMode = .scaleAspectFill
        containerLeftView.addSubview(positionImageView)
        
        let buttonLeft = UIBarButtonItem(customView: containerLeftView)
        
        navigationItem.leftBarButtonItem = buttonLeft
    }

    private func curentDate() -> String {
        let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMMM yyyy"
                
                let currentDate = Date()
                
                let formattedDate = dateFormatter.string(from: currentDate)

        return formattedDate
    }
}
