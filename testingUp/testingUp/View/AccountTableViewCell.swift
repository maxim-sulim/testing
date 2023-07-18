//
//  AccountTableViewCell.swift
//  testingUp
//
//  Created by Максим Сулим on 14.07.2023.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

    
    private var storage: UserStorageProtocol = UserStorage()
    
    @IBOutlet weak var lableRight: UIImageView!
    
    @IBOutlet weak var backgoundCell: UIImageView!
    
    @IBOutlet weak var imageAccount: UIImageView!
    
    @IBOutlet weak var nameAccount: UILabel!
    
    @IBOutlet weak var locationAccount: UILabel!
    
    
    func configureAccountCell() {
        
        let account = storage.loadAccount()
        
        self.imageAccount.image = UIImage(data: account.imageAccount)
        self.imageAccount.contentMode = .scaleAspectFit
        self.imageAccount.layer.cornerRadius = imageAccount.frame.size.height / 2
        self.imageAccount.contentMode = .scaleAspectFill
        self.nameAccount.text = account.nameUser
        self.locationAccount.text = account.location
        self.backgoundCell.layer.cornerRadius = 20
        self.backgoundCell.backgroundColor = Resources.Color.activeBlu.withAlphaComponent(0.4)
        self.lableRight.tintColor = Resources.Color.activeBlu
        
            }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

}
