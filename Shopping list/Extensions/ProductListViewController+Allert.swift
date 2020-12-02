//
//  ProductListViewController+Allert.swift
//  Shopping list
//
//  Created by Виктор Петровский on 28.11.2020.
//

import UIKit

extension ProductListViewController {
    
    func allertShow(currentName: String, currentDiscription: String, currentRaiting: Int, numberOFcell: IndexPath) {
        
        var nameField = UITextField() //хранит название нового списка
        var descriptionField = UITextField()
        var raitingField = UITextField()
        
        let allert = UIAlertController(title: "Edit Item", message: "", preferredStyle: .alert)
        
        let editAction = UIAlertAction(title: "Save changes", style: .destructive) { (action) in
            guard let nametext = nameField.text, let descriptionText = descriptionField.text else { return }
            if let raiting = raitingField.text {
                let name = nametext == "" ? "No name" : nametext
                DataShoppingList.arrayOfProducts[numberOFcell.row].name = name
                DataShoppingList.arrayOfProducts[numberOFcell.row].description = descriptionText
                DataShoppingList.arrayOfProducts[numberOFcell.row].raiting = Int(raiting) ?? currentRaiting
            }
            self.saveData()
            self.tableView.reloadRows(at: [numberOFcell], with: .automatic)
        }
        
        let dismissAction = UIAlertAction(title: "Close", style: .cancel) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
        
        allert.addTextField { (name) in // добавляем поле для ввода текста
            name.text = currentName
            name.placeholder = "Enter name"
            nameField = name
        }
        
        allert.addTextField { (description) in // добавляем поле для ввода текста
            description.text = currentDiscription
            description.placeholder = "Enter description of product"
            descriptionField = description
        }
        
        allert.addTextField { (raiting) in // добавляем поле для ввода текста
            raiting.text = "\(currentRaiting)"
            raiting.placeholder = "Value from 0 to 5"
            raiting.keyboardType = .numberPad
            raitingField = raiting
        }
        
        allert.addAction(editAction) //вызываем действие и презентуем алерт
        allert.addAction(dismissAction)
        
        self.present(allert, animated: true, completion: nil)
    }

    
}
