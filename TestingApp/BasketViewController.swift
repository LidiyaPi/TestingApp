//
//  BasketViewController.swift
//  TestingApp
//
//  Created by Лидия Пятаева on 02.07.2023.
//

import UIKit
import SnapKit

class BasketViewController: UIViewController {
    
    var quantities: [Int] = [0, 0, 0, 0, 0]
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(BasketTableViewCell.self, forCellReuseIdentifier: "BasketTableViewCell")
        return tableView
    }()
    
    private let couponName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "SF Pro Display", size: 25)
        label.text = "title"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addDelegates()
        addConstraints()
        
        view.backgroundColor = .white
        setupNavigationController()
    }
    
    private func addSubviews() {
        view.addSubview(couponName)
        view.addSubview(tableView)
    }
    
    private func addDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func addConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.horizontalEdges.equalToSuperview()
//            make.height.equalTo(500)
            }
        }
    
    private func setupNavigationController(){

        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        containerView.layer.cornerRadius = 25
        containerView.clipsToBounds = true
        
        let button = UIBarButtonItem(customView: containerView)
        navigationItem.rightBarButtonItem = button

        // Установка кнопки в правую часть navigationBar
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

        // Создание кастомной UIBarButtonItem с кастомным представлением
        let buttonLeft = UIBarButtonItem(customView: containerLeftView)

        // Установка кнопки в левую часть navigationBar
        navigationItem.leftBarButtonItem = buttonLeft
    }
    
    private func curentDate() -> String {
        let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMMM yyyy"
                
                // Получение текущей даты
                let currentDate = Date()
                
                // Форматирование текущей даты в строку
                let formattedDate = dateFormatter.string(from: currentDate)

        return formattedDate
    }
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "BasketTableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell", for: indexPath) as! BasketTableViewCell
        if cell == nil {
            cell = BasketTableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        let quantity = quantities[indexPath.row]
        cell.quantity = quantity
        cell.minusButtonAction = {
                cell.quantity -= 1
        }
        cell.plusButtonAction = {
            cell.quantity += 1
            }
        return cell
        }
    }

