//
//  DishSelectionViewController.swift
//  testingUp
//
//  Created by Максим Сулим on 30.06.2023.
//

import UIKit

protocol DishWithATag: AnyObject {
    var dataDishes: [Dish] { get set}
    var arrTags: [Tags] { get set }
    func relodDishes(tag: String)
    func showDishFull(dish: Dish)
    
}

class DishSelectionViewController: UIViewController, DishWithATag {
    
    
    
    func showDishFull(dish: Dish) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ZoomDishViewController") as? ZoomDishViewController else {
            return
        }
        vc.viewDidLoad()
        vc.configureDishCell(dish: dish)
        vc.nameDish.text = dish.name
        vc.priceAndPortion.text = "\(dish.price)₽  \(dish.weight)гр."
        vc.discriptionDish.text = dish.description
        
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
        
    }
    
    func relodDishes(tag: String) {
        index = 0
        if tag == NameTagsDish.all {
            self.isSelectedTag = false
            self.dishCollectionView.reloadData()
            self.tagsCollectionView.reloadData()
        } else {
            self.isTagDish = []
            for i in 0..<dataDishes.count {
                for j in 0..<dataDishes[i].tegs!.count {
                    if dataDishes[i].tegs![j] == tag {
                        isTagDish.append(dataDishes[i])
                    }
                }
            }
            self.isSelectedTag = true
            self.dishCollectionView.reloadData()
            self.tagsCollectionView.reloadData()
        }
        
    }
    fileprivate var scrollOffset: CGPoint = CGPoint()
    var isTagDish = [Dish]()
    var dataDishes = [Dish]()
    var arrTags = [Tags]()
    var index = 0
    var nameCategory = ""
    var isSelectedTag = false
    
    @IBOutlet weak var dishCollectionView: UICollectionView!
    
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    
    @IBOutlet weak var constraintTableToSave: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dishCollectionView.delegate = self
        self.tagsCollectionView.delegate = self
        self.dishCollectionView.dataSource = self
        self.tagsCollectionView.dataSource = self
        self.tagsCollectionView.backgroundColor = .clear
        //configureTegsCollection()
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            topItem.backBarButtonItem?.tintColor = .black
        }
        
        self.navigationItem.title = nameCategory
        
    }
    
    private func configureTegsCollection() {
       
        self.tagsCollectionView.layer.shadowColor = UIColor.gray.withAlphaComponent(0.4).cgColor
        self.tagsCollectionView.layer.shadowOffset = CGSizeMake(0, 30)
        self.tagsCollectionView.layer.shadowRadius = 15
        self.tagsCollectionView.layer.shadowOpacity = 1
        self.tagsCollectionView.clipsToBounds = false
        self.tagsCollectionView.layer.masksToBounds = false
    }
    
    // рефактор: вытащить из условия цикл, сделать универсальным
    
        func loadDishes(nameCategory: String) {
            
        let urlStr = "https://run.mocky.io/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b"
        
        NetworkData.shared.workDataDishes(urlString: urlStr) { result, error in
            
            if error == nil {
               
                guard let resultData = result else {
                    return
                }
                if nameCategory == "Азиатская кухня" {
                    
                    let arrDish = resultData.dishes
                    let arrIdNeed = [1,2,3,4,5,6]
                    var tryTags = [String]()
                    
                    for i in 0..<arrDish.count {
                        if arrIdNeed.contains(arrDish[i].id!) {
                            self.dataDishes.append(arrDish[i])
                            tryTags.append(contentsOf: arrDish[i].tegs!)
                        }
                        
                    }
                    let sortArrTag = tryTags.removeDuplicates()
                    for i in 0..<sortArrTag.count {
                        self.arrTags.append(Tags(name: sortArrTag[i], isSelected: false))
                    }
                    self.arrTags[0].isSelected = true
                    self.dishCollectionView.reloadData()
                    self.tagsCollectionView.reloadData()
                    
                } else {
                    var tryTags = [String]()
                    self.dataDishes = resultData.dishes
                    self.dishCollectionView.reloadData()
                    
                    for i in 0..<self.dataDishes.count {
                        tryTags.append(contentsOf: self.dataDishes[i].tegs!)
                    }
                    
                    let sortArrTag = tryTags.removeDuplicates()
                    for i in 0..<sortArrTag.count {
                        self.arrTags.append(Tags(name: sortArrTag[i], isSelected: false))
                        
                    }
                    self.arrTags[0].isSelected = true
                    self.tagsCollectionView.reloadData()
                }
                
            } else {
                print(error!.localizedDescription)
            }
            
        }
    }
    
}


extension DishSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == tagsCollectionView) {
            return arrTags.count
        } else {
            if isSelectedTag == false {
                return dataDishes.count / 3
            } else {
                if isTagDish.count >= 3 {
                    return isTagDish.count / 3
                } else {
                    return 1
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == tagsCollectionView) {
            
            let cell = tagsCollectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as? TagsCollectionViewCell
            
                cell?.configure(with: TagsCollectionViewCell.ViewModel(index: indexPath.row,
                                                            name: arrTags[indexPath.row].name,
                                                            isSelected: arrTags[indexPath.row].isSelected))
            
            cell?.delegate = self
            return cell!
            
        } else {
            if isSelectedTag == false {
                
                let cell = dishCollectionView.dequeueReusableCell(withReuseIdentifier: "DishCell", for: indexPath) as? DishesCollectionViewCell
                
                if indexPath.row == 0 {
                    
                    cell?.configureDishCell(category: dataDishes, index: indexPath.row)
                    
                } else {
                    
                    cell?.configureDishCell(category: dataDishes, index: index)
                }
                
                index += 3
                cell?.delegate = self
                
                return cell!
            } else {
                
                let cell = dishCollectionView.dequeueReusableCell(withReuseIdentifier: "DishCell", for: indexPath) as? DishesCollectionViewCell
                
                if indexPath.row == 0 {
                    
                    cell?.configureDishCell(category: isTagDish, index: indexPath.row)
                    
                } else {
                    
                    cell?.configureDishCell(category: isTagDish, index: index)
                }
                
                index += 3
                
                cell?.delegate = self
                return cell!
            }
        }
        
    }
    
}

extension DishSelectionViewController: UIScrollViewDelegate {
    
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if  scrollView.contentOffset.y > 0 {
            self.configureTegsCollection()
            self.constraintTableToSave.constant = 1
            UIView.animate(withDuration: 0.2, delay: 0.1) {
                self.view.layoutIfNeeded()
            }
            
        } else {
            self.tagsCollectionView.layer.shadowOpacity = 0
            self.constraintTableToSave.constant = 51
            UIView.animate(withDuration: 0.2, delay: 0.1) {
                self.view.layoutIfNeeded()
            }
        }
        scrollOffset = scrollView.contentOffset
    }

    
}
