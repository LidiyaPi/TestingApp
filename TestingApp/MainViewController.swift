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
    var sortedArray = [String: [Any]]()
    
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
        subtitleLabel.alpha = 0.5
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
    
    private func curentDate() -> String {
        let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMMM, yyyy"
                
                // Получение текущей даты
                let currentDate = Date()
                
                // Форматирование текущей даты в строку
                let formattedDate = dateFormatter.string(from: currentDate)

        return formattedDate
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
        
            NetworkService.shared.requestMenu { (response, error) in
                if error != nil {
                    print("Не удалось получить массив меню")
                }
                guard let response = response else { return }
                self.menuArray = response
                self.fabricArrayTegs()
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
        navigationController?.pushViewController(menuViewController, animated: true)
        menuViewController.setup(model: sortedArray)
    }
}

