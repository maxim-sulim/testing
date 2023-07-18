//
//  EdditAccountViewController.swift
//  testingUp
//
//  Created by Максим Сулим on 16.07.2023.
//

import UIKit


class EdditAccountViewController: UITableViewController {
    
    private var storage: UserStorageProtocol = UserStorage()
    
    
    @IBOutlet weak var backViewImageCell: UIImageView!
    
    @IBOutlet weak var accountImage: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var bauttonEdditImage: UIButton!
    
    
    
    var button = UIButton()
    var buttonActive = false
    
    var user: UserModelAccountProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigateItem()
        configureButton()
        configureEdditCell()
        self.nameTextField.delegate = self
        self.locationTextField.delegate = self
        
    }
    
    
   private func configureEdditCell() {
        
       self.accountImage.image = UIImage(data: user!.imageAccount) ?? UIImage(named: "imageProfile")
        self.accountImage.contentMode = .scaleAspectFill
        self.accountImage.layer.cornerRadius = self.accountImage.frame.size.height / 2
        self.backViewImageCell.layer.cornerRadius = 20
        self.backViewImageCell.backgroundColor = Resources.Color.activeBlu.withAlphaComponent(0.4)
        self.nameTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        self.locationTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
       self.nameTextField.placeholder = user?.nameUser ?? ""
       self.locationTextField.placeholder = user?.location ?? ""
    }
    
    private func configureNavigateItem() {
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            topItem.backBarButtonItem?.tintColor = .black
        }
        
        
    }
    
    private func configureButton() {
        view.addSubview(button)
        button.addTarget(self, action: #selector(svaeUserAccount), for: .touchUpInside)
        
        let viewHeight = self.view.frame.height
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -(viewHeight / 50)),
            button.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            button.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            button.widthAnchor.constraint(equalToConstant: CGFloat(Int(self.view.frame.width) - 32)),
            button.heightAnchor.constraint(equalToConstant: 48)
        ])
        if self.buttonActive == true {
            button.backgroundColor = Resources.Color.activeBlu
        } else {
            button.backgroundColor = Resources.Color.activeBlu.withAlphaComponent(0.4)
        }
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Сохранить", for: .normal)
        
    }
    
    @objc private func svaeUserAccount () {
     
        if buttonActive == true {
            
            let imageData = accountImage.image?.pngData()
            
            var name: String?
            if nameTextField.text != "" {
                name = nameTextField.text
            }
            
            var location: String?
            if locationTextField.text != "" {
                location = locationTextField.text
            }
            
            let userAccount  = UserModelAccount(nameUser: name ?? user!.nameUser,
                                                imageAccount: imageData ?? user!.imageAccount,
                                                location: location ?? user!.location)
            storage.saveAccount(userAcc: userAccount)
            navigationController?.popViewController(animated: true)
        }
      
    }
     
    // MARK: tableDelegate work
    
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 206
        } else {
            return 60
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Изменить имя"
        } else if section == 2 {
            return "Изменить город"
        }
        return ""
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let actionSheetController = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Камера", style: .default) {_ in
                
                self.chooseImagePicker(source: UIImagePickerController.SourceType.camera)
            }
            let photo = UIAlertAction(title: "Фото", style: .default) {_ in
                
                self.chooseImagePicker(source: UIImagePickerController.SourceType.photoLibrary)
            }
            
            let cancel = UIAlertAction(title: "Отмена", style: .cancel)
            
            actionSheetController.addAction(camera)
            actionSheetController.addAction(photo)
            actionSheetController.addAction(cancel)
            
            present(actionSheetController, animated: true)
            
        } else {
            view.endEditing(true)
        }
        
    }
    
}

extension EdditAccountViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged () {
        
        if nameTextField.text?.isEmpty == false || locationTextField.text?.isEmpty == false {
            self.buttonActive = true
            configureButton()
        } else {
            self.buttonActive = false
            configureButton()
        }
        
    }
    
}

extension EdditAccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker , animated: true)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        accountImage.image = info[.editedImage] as? UIImage
        accountImage.contentMode = .scaleToFill
        accountImage.clipsToBounds = true
        dismiss(animated: true)
    }
    
}
