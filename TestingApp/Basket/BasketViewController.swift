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
    var basketDishes = [BasketDishes]()
    
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
        
        guard let tabBarController = tabBarController as? TabBarViewController else {
            return
        }
        tabBarController.tabBarControllerDelegate = self
    }
    
    private func addConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.horizontalEdges.equalToSuperview()
            }
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
    
extension BasketViewController: TabBarControllerDelegate {
    func addToCartButtonTapped(dish: Dishes) {
        print("работаем с добавлением массива dish в словарь")
    }
}
