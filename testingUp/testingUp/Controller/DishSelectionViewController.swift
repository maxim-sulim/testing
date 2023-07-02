//
//  DishSelectionViewController.swift
//  testingUp
//
//  Created by Максим Сулим on 30.06.2023.
//

import UIKit

class DishSelectionViewController: UIViewController {

    
    var dataDishes = [Dish]()
    var index = 0
    var nameCategory = ""
    
    @IBOutlet weak var collectionViewDish: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDishes()
        self.collectionViewDish.delegate = self
        self.collectionViewDish.dataSource = self
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            topItem.backBarButtonItem?.tintColor = .black
        }
        self.navigationItem.title = nameCategory
        
    }
    
    private func loadDishes() {
        let urlStr = "https://run.mocky.io/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b"
        
        NetworkData.shared.workDataDishes(urlString: urlStr) { result, error in
            
            if error == nil {
               
                guard let resultData = result else {
                    return
                }
                self.dataDishes = resultData.dishes
                print(self.dataDishes)
                self.collectionViewDish.reloadData()
            } else {
                print(error!.localizedDescription)
                
            }
            
        }
    }
    
}


extension DishSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return dataDishes.count / 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionViewDish.dequeueReusableCell(withReuseIdentifier: "DishCell", for: indexPath) as? DishesCollectionViewCell
        
        if indexPath.row == 0 {
            
            cell?.configureDishCell(category: dataDishes, index: indexPath.row)
            
        } else {
            
            cell?.configureDishCell(category: dataDishes, index: index)
        }
        
            index += 3
        
        return cell!
    }
    
}
