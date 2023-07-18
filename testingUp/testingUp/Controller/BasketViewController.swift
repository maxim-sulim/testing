//
//  BasketViewController.swift
//  testingUp
//
//  Created by Максим Сулим on 30.06.2023.
//

import UIKit

protocol BascketReloadTableProtocol {
    func loadStorage()
    func reloadButtonPrice()
}

class BasketViewController: UIViewController, BascketReloadTableProtocol {
    
    private var storage: UserStorageProtocol = UserStorage()
    var dishArr = [UserModelBascketProtocol]()
    private var button = UIButton()
        
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func removeBascketItem(_ sender: Any) {
        removeBascket()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadStorage()
        configureButton()
        configureBarItem()
    }
    
    func loadStorage() {
        dishArr = []
     let result = storage.loadBascket()
        
        for bascketDish in result {
            dishArr.append(bascketDish)
        }
        self.tableView.reloadData()
    }
    
    private func removeBascket() {
        storage.removeBascket()
        dishArr = []
        reloadButtonPrice()
        self.tableView.reloadData()
    }
    
     func configureBarItem() {
         let user = storage.loadAccount()
        if let barItem = navigationController?.navigationBar.topItem {
            let imageProgile = UIImage(named: "Unknown")
            barItem.leftBarButtonItem?.title = user.location

            barItem.leftBarButtonItem?.tintColor = .black
            barItem.leftBarButtonItem?.image = imageProgile
            
            barItem.rightBarButtonItem?.title = "Очистить корзину"
            barItem.rightBarButtonItem?.tintColor = .black
        }
        
    }
    
    func reloadButtonPrice() {
        var sumPrice = 0
        
        for index in 0..<dishArr.count {
            sumPrice += dishArr[index].countDish * dishArr[index].price
        }
        
        button.setTitle("Оплатить \(sumPrice)", for: .normal)
    }
    
    private func configureButton() {
        view.addSubview(button)
        var sumPrice = 0
        let viewHeight = self.view.frame.height
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -(viewHeight / 50)),
            button.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            button.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            button.widthAnchor.constraint(equalToConstant: CGFloat(Int(self.view.frame.width) - 32)),
            button.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        button.layer.cornerRadius = 10
        button.backgroundColor = Resources.Color.activeBlu
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        
        for index in 0..<dishArr.count {
            sumPrice += dishArr[index].countDish * dishArr[index].price
        }
        
        button.setTitle("Оплатить \(sumPrice)", for: .normal)
        
    }

}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellBascket", for: indexPath) as? BascketTableViewCell
        
        cell?.configureBascketCell(dishBascket: dishArr[indexPath.row])
        cell?.delegate = self
        
        return cell!
    }
    
    
    
}
