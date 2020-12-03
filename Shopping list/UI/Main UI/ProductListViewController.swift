//
//  ViewController.swift
//  Shopping list
//
//  Created by Виктор Петровский on 27.11.2020.
//

import UIKit

class ProductListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100
        tableView.delegate           = self
        tableView.dataSource         = self
        tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        loadItems()
        
    }

    @IBAction func sortButtonTapped(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.isEditing = false
            sender.title        = "Sort"
            
        } else {
            sender.title        = "Done"
            tableView.isEditing = true
        }
    }
    
    @IBAction func addNewItemTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "ToAddItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? AddItemViewController else { return }
        
        destinationVC.callback = { (name, description, raiting) in
            DataShoppingList.arrayOfProducts.append(ModelShoppingList(name: name,
                                                                      description: description,
                                                                      raiting: raiting))
            self.saveData()
            self.reloadData()
        }
    }
    
    
    private func saveData() {
        guard let dataFile = dataFilePath else { return }
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(DataShoppingList.arrayOfProducts)
            try data.write(to: dataFile)
            
        } catch {
            print("Error encoding \(error)")
        }
    }
    
    private func loadItems() {
        guard let dataFile = dataFilePath else { return }
        
        if let data = try? Data(contentsOf: dataFile) {
            let decoder = PropertyListDecoder()
            do {
                DataShoppingList.arrayOfProducts = try decoder.decode([ModelShoppingList].self, from: data)
            } catch {
                print("Error at reading data: \(error)")
            }
        }
    }
    
    private func reloadData() {
        tableView.reloadData()
    }
    
    //MARK: - : UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataShoppingList.arrayOfProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell                   = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! ProductCell
        cell.name.text             = DataShoppingList.arrayOfProducts[indexPath.row].name
        cell.descriptionLabel.text = DataShoppingList.arrayOfProducts[indexPath.row].description
        cell.raiting               = DataShoppingList.arrayOfProducts[indexPath.row].raiting
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
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
        action.image           = UIImage.init(systemName: "trash")
        action.backgroundColor = .red
        
        return action
    }
    
    private func editAction(at indexPath: IndexPath) -> UIContextualAction {
        
        let action = UIContextualAction(style: .normal, title: "Edit") { (_,_,success) in
            
            let array = DataShoppingList.arrayOfProducts[indexPath.row]
            self.alertShow(currentName: array.name, currentDiscription: array.description, currentRaiting: array.raiting, numberOFcell: indexPath)
            
            self.saveData()
            success(true)
        }
        
        action.image           = UIImage.init(systemName: "square.and.pencil")
        action.backgroundColor = .orange
        return action
    }
    
    //MARK: - Alert
    private func alertShow(currentName: String, currentDiscription: String, currentRaiting: Int, numberOFcell: IndexPath) {
        
        var nameField        = UITextField()
        var descriptionField = UITextField()
        var raitingField     = UITextField()
        
        let alert = UIAlertController(title: "Edit Item", message: "", preferredStyle: .alert)
        
        let editAction = UIAlertAction(title: "Save changes", style: .destructive) { (action) in
            guard let nametext = nameField.text, let descriptionText = descriptionField.text else { return }
            
            if let raiting = raitingField.text {
    
                let name = nametext == "" ? "No name" : nametext
                let description = descriptionText == "" ? " " : descriptionText
                
                DataShoppingList.arrayOfProducts[numberOFcell.row].name        = name
                DataShoppingList.arrayOfProducts[numberOFcell.row].description = description
                DataShoppingList.arrayOfProducts[numberOFcell.row].raiting     = Int(raiting) ?? currentRaiting
            }
            
            self.saveData()
            self.tableView.reloadRows(at: [numberOFcell], with: .automatic)
        }
        
        let dismissAction = UIAlertAction(title: "Close", style: .cancel) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
        
        alert.addTextField { (name) in
            name.text        = currentName
            name.placeholder = "Enter name"
            nameField        = name
        }
        
        alert.addTextField { (description) in
            description.text        = currentDiscription
            description.placeholder = "Enter description of product"
            descriptionField        = description
        }
        
        alert.addTextField { (raiting) in
            raiting.text         = "\(currentRaiting)"
            raiting.placeholder  = "Value from 0 to 5"
            raiting.keyboardType = .numberPad
            raitingField         = raiting
        }
        
        alert.addAction(editAction)
        alert.addAction(dismissAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}


