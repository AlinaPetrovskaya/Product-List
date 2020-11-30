//
//  ProductListViewController+UITableViewDelegate.swift
//  Shopping list
//
//  Created by Виктор Петровский on 28.11.2020.
//

import UIKit

extension ProductListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = editAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
    private func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (_,_,_) in
            DataShoppingList.arrayOfProducts.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        action.image = UIImage.init(systemName: "trash")
        action.backgroundColor = .red
        
        return action
    }
    
    private func editAction(at indexPath: IndexPath) -> UIContextualAction {
        
        var array = DataShoppingList.arrayOfProducts[indexPath.row]
        var nameField = UITextField() //хранит название нового списка
        var descriptionField = UITextField()
        var raitingField = UITextField()
        
        let action = UIContextualAction(style: .normal, title: "Edit") { (_,_,success) in
            let alert = UIAlertController(title: "Edit Item", message: "", preferredStyle: .alert)
            
            let editAction = UIAlertAction(title: "Save changes", style: .destructive) { _ in
                if let raiting = raitingField.text {
                    array.name = nameField.text ?? "No name"
                    array.description = descriptionField.text ?? ""
                    array.raiting = Int(raiting) ?? array.raiting
                }
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
                success(true)
            }
            
            let dismissAction = UIAlertAction(title: "Close", style: .cancel) { _ in
                    self.dismiss(animated: true, completion: nil)
                    success(true)
                }
            
            alert.addTextField { (name) in
                name.text = array.name
                name.placeholder = "Enter name"
                nameField = name
            }
            
            alert.addAction(editAction) //вызываем действие и презентуем алерт
            alert.addAction(dismissAction)
            
            self.present(alert, animated: true, completion: nil)
        }

        
        action.image = UIImage.init(systemName: "square.and.pencil")
        action.backgroundColor = .orange
        return action
    }
}

//alert.addTextField { (description) in
//    description.text = array.description
//    description.placeholder = "Enter description of product"
//    descriptionField = description
//}
//
//alert.addTextField { (raiting) in
//    raiting.text = "\(array.raiting)"
//    raiting.placeholder = "Value from 0 to 5"
//    raiting.keyboardType = .numberPad
//    raitingField = raiting
//}
