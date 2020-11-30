//
//  ProductListViewController+UITableViewDataSource.swift
//  Shopping list
//
//  Created by Виктор Петровский on 28.11.2020.
//

import UIKit

extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataShoppingList.arrayOfProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! ProductCell
        cell.name.text = DataShoppingList.arrayOfProducts[indexPath.row].name
        cell.descriptionLabel.text = DataShoppingList.arrayOfProducts[indexPath.row].description
        cell.raiting = DataShoppingList.arrayOfProducts[indexPath.row].raiting
        return cell
    }
    
    
}
