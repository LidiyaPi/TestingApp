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
    
    var summ = 0
    
    var payment: Int = 0 {
        didSet {
//                   if quantity < 0 {
//                       quantity = 0
//                   }
//            payment =
//            paymentButton.text = "\(payment)"
        }
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(BasketTableViewCell.self, forCellReuseIdentifier: "BasketTableViewCell")
        return tableView
    }()
    
    private let paymentButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 10
        button.setTitle("Оплатить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
//        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchDown)
        button.layer.borderWidth = 0.0
        button.backgroundColor = UIColor(red: 51/255, green: 100/255, blue: 224/255, alpha: 1)
        button.alpha = 1
        return button
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
        view.addSubview(paymentButton)
    }
    
    private func addDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func addConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets)
            make.bottom.equalTo(paymentButton.snp.top).inset(-16)
            make.horizontalEdges.equalToSuperview()
        }
        
        paymentButton.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.left.equalToSuperview().inset(16)
            make.width.equalTo(343)
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
        var cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell", for: indexPath) as! BasketTableViewCell
        if cell == nil {
            cell = BasketTableViewCell(style: .default, reuseIdentifier: "BasketTableViewCell")
        }
        let quantity = basket[indexPath.row].quantity
        cell.quantity = quantity
        cell.minusButtonAction = {
            cell.quantity -= 1
            self.basket[indexPath.row].quantity -= 1
                self.summ -= self.basket[indexPath.row].dish.price * self.basket[indexPath.row].quantity
            
            if cell.quantity == 0 {
                print("sd")
                self.basket.remove(at: self.basket[indexPath.row].quantity)
                tableView.reloadData()
            }
        }
        cell.plusButtonAction = {
            cell.quantity += 1
            self.basket[indexPath.row].quantity += 1
            self.summ += self.basket[indexPath.row].dish.price * self.basket[indexPath.row].quantity
            }
        self.paymentButton.setTitle("Оплатить \(summ) Р", for: .normal)
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
