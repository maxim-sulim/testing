//
//  ViewController.swift
//  testingUp
//
//  Created by Максим Сулим on 30.06.2023.
//

import UIKit


protocol CategoryShow: AnyObject {
    func segueNameCategory(name: String)
}

class MainViewController: UIViewController, CategoryShow {

    var dataCategories = [Сategory]()
    private var storage: UserStorageProtocol = UserStorage()
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureBarItem()
    }

    private func loadCategories() {
        let urlStr = "https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54"
        
        NetworkData.shared.workDataCategories(urlString: urlStr) { result, error in
            
            if error == nil {
               
                guard let resultData = result else {
                    return
                }
                self.dataCategories = resultData.сategories
                print(self.dataCategories)
                self.collectionView.reloadData()
            } else {
                print(error!.localizedDescription)
                
            }
            
        }
    }
    
    private func configureBarItem() {
        let user = storage.loadAccount()
        if let barItem = navigationController?.navigationBar.topItem {
            barItem.leftBarButtonItem?.title = user.location

            barItem.leftBarButtonItem?.tintColor = .black
            
        }
    }
    
    func segueNameCategory(name: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vcDish = storyboard.instantiateViewController(withIdentifier: "DishVc") as? DishSelectionViewController else {
            return
        }
        vcDish.nameCategory = name
        if vcDish.nameCategory == "Азиатская кухня" {
            vcDish.loadDishes(nameCategory: name)
        } else {
            vcDish.loadDishes(nameCategory: "all")
        }
        vcDish.modalPresentationStyle = .fullScreen
        vcDish.modalTransitionStyle = .crossDissolve
        show(vcDish, sender: true)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoriesCollectionViewCell
        
        
        cell?.configureCategoriesCell(element: dataCategories[indexPath.row])
        cell?.delegate = self
        
        
        return cell!
    }
    
}

