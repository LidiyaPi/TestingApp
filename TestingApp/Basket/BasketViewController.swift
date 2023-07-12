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
    
    var basket = [BasketDishes]()
    var dishes = [Dishes]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(BasketTableViewCell.self, forCellReuseIdentifier: "BasketTableViewCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addDelegates()
        addConstraints()
        view.backgroundColor = .white
        navigationItem.title = "sda"
        setupNavigationController()
     }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func addDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func addConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            }
        }
    
    
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        basket.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell", for: indexPath) as! BasketTableViewCell
        if cell == nil {
            cell = BasketTableViewCell(style: .default, reuseIdentifier: "BasketTableViewCell")
        }
        let quantity = quantities[indexPath.row]
        cell.quantity = quantity
        cell.minusButtonAction = {
                cell.quantity -= 1
        }
        cell.plusButtonAction = {
            cell.quantity += 1
            }
        var basketGuarded = basket[indexPath.row]
        cell.quantityLabel.text = String(basketGuarded.quantity)
        cell.setup(model: basket[indexPath.row])
        if quantity < 0 { tableView.reloadRows(at: [indexPath], with: .automatic)}
        
        return cell
    }
}

 
    extension BasketViewController: ProductViewControllerDelegate {
        func addToBasket(dish: Dishes) {
            var existingDishIndex: Int?
            
            for (index, basketDish) in basket.enumerated() {
                if basketDish.dish == dish {
                    existingDishIndex = index
                    break
                }
            }
            if let index = existingDishIndex {
                basket[index].quantity += 1
            } else {
                let newBasketDish = BasketDishes(quantity: 1, dish: dish)
                basket.append(newBasketDish)
            }
            
            tableView.reloadData()
        }
    }
