//
//  BasketViewController.swift
//  TestingApp
//
//  Created by Лидия Пятаева on 02.07.2023.
//

import UIKit
import SnapKit

class BasketViewController: UIViewController {
    
    private let navView = BasketNavigationViewController()
    private var basket = [BasketDishes]()
    private var summ = 0
 
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(BasketTableViewCell.self, forCellReuseIdentifier: "BasketTableViewCell")
        return tableView
    }()
    
    private let paymentButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderWidth = 0.0
        button.backgroundColor = UIColor(red: 51/255, green: 100/255, blue: 224/255, alpha: 1)
        button.alpha = 1
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        paymentButton.setTitle("Оплатить \(summ) Р", for: .normal)
    }
    
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
        view.addSubview(navView)
        view.addSubview(tableView)
        view.addSubview(paymentButton)
    }
    
    private func addDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func addConstraints() {
        
        navView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(-5)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navView.snp.bottom).offset(16)
            make.bottom.equalTo(paymentButton.snp.top).inset(16)
            make.horizontalEdges.equalToSuperview()
        }
        
        paymentButton.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(48)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell", for: indexPath) as! BasketTableViewCell
        let quantity = basket[indexPath.row].quantity
        cell.quantity = quantity
        cell.minusButtonAction = {
            cell.quantity -= 1
            self.basket[indexPath.row].quantity -= 1
                self.summ -= self.basket[indexPath.row].dish.price
            self.paymentButton.setTitle("Оплатить \(self.summ) Р", for: .normal)
            
            if cell.quantity == 0 {
                self.basket.remove(at: indexPath.row)
                tableView.reloadData()
            }
        }
        cell.plusButtonAction = {
            cell.quantity += 1
            self.basket[indexPath.row].quantity += 1
            self.summ += self.basket[indexPath.row].dish.price
            self.paymentButton.setTitle("Оплатить \(self.summ) Р", for: .normal)
            }
        
        cell.quantityLabel.text = String(basket[indexPath.row].quantity)
        cell.setup(model: basket[indexPath.row])
        if quantity < 0 { tableView.reloadRows(at: [indexPath], with: .automatic)}
        
        return cell
    }
}

    extension BasketViewController: ProductViewControllerDelegate {
        func addToBasket(dish: Dishes) {
            var existingDishIndex: Int?
            summ += dish.price
            
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
