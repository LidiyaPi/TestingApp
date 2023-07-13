//
//  ViewController.swift
//  TestingApp
//
//  Created by Лидия Пятаева on 02.07.2023.
//

import UIKit
import SnapKit
import SVProgressHUD

class MainViewController: UIViewController {
    
    private var category = Categories(сategories: [])
    private var finishTegs = [Tegs]()
    var menuArray = MenuModel(dishes: [])
    var sortedArray = [String: [Dishes]]()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegates()
        addSubViews()
        addConstraints()
        view.backgroundColor = .white
        setupNavigationController()
        responceNetwork()
    }
    
    private func delegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func addSubViews() {
        view.addSubview(tableView)
    }
    
    private func addConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    private func responceNetwork() {
        DispatchQueue.main.async {
            NetworkService.shared.requestCategory { (response, error) in
                if error != nil {
                    print("Не удалось получить категории")
                }
                guard let response = response else { return }
                self.category = response
                self.tableView.reloadData()
            }
        }
    }
    
    private func fabricArrayTegs() {
        let dishes = self.menuArray.dishes
        for dish in dishes {
            if let tags = dish.tegs as? [String] {
                for tag in tags {
                    if self.sortedArray[tag] == nil {
                        self.sortedArray[tag] = [dish]
                        print(self.sortedArray)
                    } else {
                        self.sortedArray[tag]?.append(dish)
                    }
                }
            }
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        158
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        category.сategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.setupCell(category.сategories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let customSpacing: CGFloat = 10 // Установите желаемый отступ между ячейками
        if indexPath.row != tableView.numberOfRows(inSection: indexPath.section) - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: customSpacing, bottom: 0, right: customSpacing)
        } else {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let menuViewController = MenuViewController()
        
        DispatchQueue.main.async {
            SVProgressHUD.show()
            NetworkService.shared.requestMenu { (response, error) in
                if error != nil {
                    print("Не удалось получить массив меню")
                }
                guard let response = response else { return }
                self.menuArray = response
                self.fabricArrayTegs()
                menuViewController.setup(model: self.sortedArray)
                SVProgressHUD.dismiss()
                self.navigationController?.pushViewController(menuViewController, animated: true)
                
            }
        }
    }
}

