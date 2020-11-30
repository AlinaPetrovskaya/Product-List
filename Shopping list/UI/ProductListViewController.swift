//
//  ViewController.swift
//  Shopping list
//
//  Created by Виктор Петровский on 27.11.2020.
//

import UIKit

class ProductListViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    
    //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
    }

    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        
        self.tableView.reloadData()
    }
    
    private func reloadData() {
        self.tableView.reloadData()
    }
}


