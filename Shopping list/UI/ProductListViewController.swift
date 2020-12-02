//
//  ViewController.swift
//  Shopping list
//
//  Created by Виктор Петровский on 27.11.2020.
//

import UIKit

class ProductListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        loadItems()
        tableView.estimatedRowHeight = 100
    }

    @IBAction func sortButtonTapped(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.isEditing = false
            sender.title = "Sort"
        } else {
            sender.title = "Done"
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
    
    private func reloadData() {
        tableView.reloadData()
    }
    
    func saveData() {
        guard let dataFile = dataFilePath else { return }
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(DataShoppingList.arrayOfProducts)
            try data.write(to: dataFile)
            
        } catch {
            print("Error encoding \(error)")
        }
    }
    
    func loadItems() {
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
}


