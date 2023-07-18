//
//  AccountViewController.swift
//  testingUp
//
//  Created by Максим Сулим on 14.07.2023.
//

import UIKit

class AccountViewController: UIViewController {

    
    private var storage: UserStorageProtocol = UserStorage()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let accountUser = storage.loadAccount()
        
        if segue.identifier == "EdditAccountViewController" {
            
            let destonation = segue.destination as! EdditAccountViewController
            destonation.user = UserModelAccount(nameUser: accountUser.nameUser, imageAccount: accountUser.imageAccount, location: accountUser.location)
            
        }
        
    }

    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        super.unwind(for: unwindSegue, towards: subsequentVC)
        
    }
    
    
}


extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return 120
        } else {
            return 150
        }
        
    }
    
  
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = UITableViewCell()
        
        if indexPath.section == 0 {
            
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell", for: indexPath) as? AccountTableViewCell else {
                return cell
            }
            
            cell.configureAccountCell()
            
            return cell
        } else if indexPath.section == 1 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteAccTableViewCell", for: indexPath) as? FavoriteAccTableViewCell else {
                return cell
            }
            
            cell.collectionView.delegate = cell
            cell.collectionView.dataSource = cell
            cell.configureFavoriteCell()
            
            return cell
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Избранные блюда"
        } else {
            return " "
        }
    }
    
}




