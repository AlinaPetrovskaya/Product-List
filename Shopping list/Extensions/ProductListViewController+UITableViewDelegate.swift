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
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        DataShoppingList.arrayOfProducts.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        saveData()
    }
    
    private func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (_,_,_) in
            DataShoppingList.arrayOfProducts.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.saveData()
        }
        action.image = UIImage.init(systemName: "trash")
        action.backgroundColor = .red
        
        return action
    }
    
    private func editAction(at indexPath: IndexPath) -> UIContextualAction {
        
        let action = UIContextualAction(style: .normal, title: "Edit") { (_,_,success) in
            let array = DataShoppingList.arrayOfProducts[indexPath.row]
            self.allertShow(currentName: array.name, currentDiscription: array.description, currentRaiting: array.raiting, numberOFcell: indexPath)
            self.saveData()
            success(true)
        }
        
        action.image = UIImage.init(systemName: "square.and.pencil")
        action.backgroundColor = .orange
        return action
    }
}
